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

character(:), allocatable :: ref(:,:)
class(*), allocatable :: b(:,:)
ref = reshape(['foo','bar'], shape=[1,2])
call foo(ref, b)
contains
  subroutine foo(a, b)
    class(*), intent(in)  :: a(:,:)
    class(*), allocatable :: b(:,:)
    allocate(b(size(a,1),size(a,2)), source=a) ! <== VALUE OF B NOT CORRECTLY DEFINED
    !allocate(b, source=a) ! unspecified bounds allowed by F2008
    select type (b)
    type is (character(*))
      if (len(b) /= len(ref)) stop 1
      if (any(shape(b) /= shape(ref))) stop 2
      if (any(b /= ref)) stop 3
    class default
      stop 4
    end select
  end subroutine
end
