!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119986
!! Fixed in gfortran 15.1.1 (20250605)
!!
!! INCORRECT RESULTS
!!
!! The gfortran 15.1.0 compiler produces incorrect results for test1 and test3
!! but correct results for test2.
!!

type :: foo
  complex :: z(3)
end type

call test1
call test2
call test3

contains

  subroutine test1
    type(foo) :: a
    a%z%re = -1
    call bar(a%z%re)
    if (any(a%z%re /= [1,2,3])) stop 1
    a%z%im = -1
    call bar(a%z%im)
    if (any(a%z%im /= [1,2,3])) stop 2
  end subroutine

  subroutine test2
    type(foo) :: a
    a%z%re = -1
    associate (z => a%z)
      call bar(z%re)
    end associate
    if (any(a%z%re /= [1,2,3])) stop 3
    a%z%im = -1
    associate (z => a%z)
      call bar(z%im)
    end associate
    if (any(a%z%im /= [1,2,3])) stop 4
  end subroutine

  subroutine test3
    type(foo) :: a
    a%z%re = -1
    associate (z_re => a%z%re)
      call bar(z_re)
    end associate
    if (any(a%z%re /= [1,2,3])) stop 5
    a%z%im = -1
    associate (z_im => a%z%im)
      call bar(z_im)
    end associate
    if (any(a%z%im /= [1,2,3])) stop 6
  end subroutine

  subroutine bar(x)
    real, intent(inout) :: x(:)
    x = [1,2,3]
  end subroutine

end
