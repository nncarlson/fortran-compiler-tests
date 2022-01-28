!! Reported to OpenCoarrays: https://github.com/sourceryinstitute/OpenCoarrays/issues/749
!!
!! DOUBLE FREE SIGABORT FROM COARRAY DEALLOCATION
!!
!! The following example triggers a double free SIGABRT when the coarray
!! with an allocatable component is automatically deallocated. Happens
!! with any number of images, including just 1.
!!
!! $ caf --version
!! OpenCoarrays Coarray Fortran Compiler Wrapper (caf version 2.9.2-13-g235167d)
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 11.2.0
!!
!! $ caf gfortran-20220128.f90 
!! 
!! $ cafrun -n 1 ./a.out
!! free(): double free detected in tcache 2
!! Program received signal SIGABRT: Process abort signal.
!!

program main

  integer :: array(10)
  call sub(array)

contains

  subroutine sub(array)
    integer, intent(in) :: array(:)
    type :: box
      integer, allocatable :: array(:)
    end type
    type(box), allocatable :: buffer[:]
    allocate(buffer[*])
    buffer%array = array
  end subroutine

end program
