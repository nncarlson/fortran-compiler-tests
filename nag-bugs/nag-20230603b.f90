!!
!! BAD LOCAL COPY OF COINDEXED OBJECT ACTUAL ARGUMENT
!!
!! In the following example a multirank coindexed object is an actual
!! argument in a subroutine call. It appears that a local copy of it
!! is being made and the copy actually passed to the subroutine.
!! This example shows that the copy is not being correctly intialized. 
!!
!! $ nagfor -coarray -num_images=2 nag-20230603b.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7129
!!
!! $ ./a.out
!! received  1.0  2.0  1.0  2.0
!! expected  1.0  2.0  3.0  4.0
!! ERROR STOP

module mod
  implicit none
contains
  subroutine sub1
    real, allocatable :: a(:,:)[:]
    allocate(a(2,2)[*])
    a = reshape([1,2,3,4], shape=[2,2]) ! all images get the same value
    sync all
    if (this_image() == 1) call sub2(a, a(:,:)[2])
  end subroutine
  subroutine sub2(x, y)
    real, intent(in) :: x(:,:), y(:,:)
    write(*,'(a,4f5.1)') 'received', y 
    write(*,'(a,4f5.1)') 'expected', x
    if (any(x /= y)) error stop
  end subroutine
end module
use mod
call sub1
end
