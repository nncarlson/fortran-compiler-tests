!! Service Request Number: 04337903
!!
!! DO CONCURRENT TYPE SPEC IGNORED IN MODULE PROCEDURE
!!
!! Declaration of the type of the index variable in the DO CONCURRENT construct
!! works correctly when the construct is in a loose procedure like external_sub
!! below, but not in a module procedure like module_sub, where the compiler
!! incorrectly complains that J has no type. This occurs with Intel 18 and 19.
!!
!! $ ifort --version
!! ifort (IFORT) 19.0.4.243 20190416
!!
!! $ ifort -c intel-20190909.f90 
!! intel-20190909.f90(33): error #6404: This name does not have a type, and must have an explicit type.   [J]
!!       array2(j) = 0 ! ERROR HERE -- J HAS NO TYPE?!
!! -------------^
!! compilation aborted for intel-20190909.f90 (code 1)
!!

subroutine external_sub
  implicit none
  real :: array1(5)
  do concurrent (integer :: j=1:5)
    array1(j) = 0 ! NO ERROR HERE -- J HAS A TYPE
  end do
end subroutine

module mod
contains
  subroutine module_sub
    implicit none
    real :: array2(5)
    do concurrent (integer :: j=1:5)
      array2(j) = 0 ! ERROR HERE -- J HAS NO TYPE?!
    end do
  end subroutine
end module
