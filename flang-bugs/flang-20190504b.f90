!! https://github.com/flang-compiler/flang/issues/713
!!
!! BAD SOURCED ALLOCATION
!!
!! The following example allocates an unlimited polymorphic array with a SOURCE=
!! argument that is an unlimited polymorphic array whose dynamic type is CHARACTER.
!! With the March 2019 binary release the value of the allocated array is not
!! correctly defined, and the code exits at the STOP 3 statement. (The value is
!! the character 'f' followed by 4 null characters.)
!!

class(*), allocatable :: b(:)
call foo(['fubar'], b)
contains
  subroutine foo(a, b)
    class(*), intent(in)  :: a(:)
    class(*), allocatable :: b(:)
    allocate(b(lbound(a,1):ubound(a,1)), source=a) ! <== VALUE OF B NOT CORRECTLY DEFINED
    !allocate(b, source=a) ! unspecified bounds allowed by F2008
    select type (b)
    type is (character(*))
      if (len(b) /= 5) stop 1
      if (size(b) /= 1) stop 2
      if (b(1) /= 'fubar') stop 3
    class default
      stop 4
    end select
  end subroutine
end
