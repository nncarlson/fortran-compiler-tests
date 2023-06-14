!! SR109842: fixed in 7.1.30
!!
!! BAD RESULTS ACCESSING MULTIRANK COARRAY DUMMY ON OTHER IMAGES
!!
!! In the following example a multirank coarray is an actual argument for a
!! coarray dummy.  Accessing the value of the dummy on other images either
!! yields the incorrect values or will occasionally segfault.
!! 
!! $ nagfor -coarray -num_images=2 nag-202306c.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7129
!!
!! $ ./a.out
!! expected  1.0  2.0  3.0  4.0
!! obtained  1.0  2.0  1.0  2.0
!! ERROR STOP
!!

module mod
  implicit none
contains
  subroutine sub1
    real, allocatable :: w(:,:)[:]
    allocate(w(2,2)[*])
    w = reshape([1,2,3,4], shape=[2,2]) ! all images get the same value
    sync all
    call sub2(w)  ! PASS COARRAY
  end subroutine
  subroutine sub2(v)
    real, intent(inout) :: v(:,:)[*]
    real :: tmp(2,2)
    if (this_image() < num_images()) then
      write(*,'(a,4f5.1)') 'expected', v
      write(*,'(a,4f5.1)') 'obtained', v(:,:)[this_image()+1] ! BAD VALUES
      !tmp = v(:,:)[this_image()+1] ! SAME HERE
      !write(*,'(a,4f5.1)') 'obtained', tmp
      if (any(v /= v(:,:)[this_image()+1])) error stop
    end if
    sync all
  end subroutine
end module
use mod
call sub1
end
