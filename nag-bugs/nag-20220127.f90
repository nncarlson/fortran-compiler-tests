!! SR108353: fixed in 7.1 build 7106
!!
!! INVALID INTERMEDIATE C CODE
!!
!! The NAG 7.1 compiler generates invalid intermediate C code for
!! the internal subroutine in this example.
!!
!! $ nagfor -coarray nag-20220127.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7103
!! [NAG Fortran Compiler normal termination]
!! nag-20220127.f90: In function 'example_IP_sub':
!! nag-20220127.f90:34:12: error: invalid type argument of '->' (have '__NAGf90_CoDope1')
!!    34 |   end subroutine
!!       |            ^~
!! nag-20220127.f90:34:35: error: invalid type argument of '->' (have '__NAGf90_CoDope1')
!!    34 |   end subroutine
!!       |                                   ^ 
!! nag-20220127.f90:34:56: error: invalid type argument of '->' (have '__NAGf90_CoDope1')
!!    34 |   end subroutine
!!       |                                                        ^ 
!! nag-20220127.f90:34:8: error: invalid type argument of '->' (have '__NAGf90_CoDope1')
!!    34 |   end subroutine
!!       |        ^~

program example
  call sub([1,2])
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
