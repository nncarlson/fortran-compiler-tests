!! https://github.com/flang-compiler/flang/issues/714
!!
!! WRONG ARRAY BOUNDS ON CLASS(*) DUMMY IN SELECT TYPE
!!
!! In the following example, an array is passed to a CLASS(*), INTENT(IN)
!! dummy argurment. The bounds of that dummy array are correct when querying
!! the polymorphic variable itself, but inside a SELECT TYPE construct the
!! bounds query return the wrong results; values that would be correct for
!! a 0-based indexing. This only occurs, however, when the actual argument
!! is an expression (array section, constant, etc). The example exits at
!! the STOP 2 statement.
!!
!! This is with the March 2019 binary release.
!!
!! $ flang flang-20190505a.f90 
!! $ ./a.out
!!  lbound=            0            0 , ubound=            0            1
!!    2
!!

integer :: a(1,2)
!call foo(a) ! THIS GIVES CORRECT RESULTS
call foo(a(:,:)) ! THIS GIVES WRONG RESULTS
!call foo(reshape([1,2],shape=[1,2])) ! THIS GIVES WRONG RESULTS
!call foo(a+1) ! THIS GIVES WRONG RESULTS
contains
  subroutine foo(b)
    class(*), intent(in) :: b(:,:)
    if (any(lbound(b) /= [1,1]) .or. any(ubound(b) /= [1,2])) then
      print *, 'lbound=', lbound(b), ', ubound=', ubound(b)
      stop 1
    end if
    select type (b)
    type is (integer)
      if (any(lbound(b) /= [1,1]) .or. any(ubound(b) /= [1,2])) then
        print *, 'lbound=', lbound(b), ', ubound=', ubound(b)
        stop 2
      end if
    end select
  end subroutine
end
