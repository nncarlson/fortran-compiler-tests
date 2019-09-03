!! Service Rquest Number: 04330684
!!
!! PUBLIC MODULE VARIABLE GONE MISSING
!!
!! In the following example BC_MODULE exports the module variable BC_MAT
!! that it imported from BC_DATA_MODULE. However when attempting to USE
!! that entity from BC_MODULE in the final module, the 19.0.4 compiler
!! incorrectly asserts that it doesn't exist or is not accessible. This
!! is a regression over earlier versions (16, 17, and 18) where the code
!! compiles without error.
!!
!! $ ifort --version
!! ifort (IFORT) 19.0.4.243 20190416
!!
!! $ ifort -c intel-20190903b.f90
!! intel-20190903b.f90(48): error #6580: Name in only-list does not exist or is not accessible.   [BC_MAT]
!!   use bc_module, only: bc_mat
!! -----------------------^
!!
!! Note that attempts to simplify or remove the other seemingly extraneous
!! code results in the error going away.
!!

module bc_info_module
  interface bcmatch
     module procedure bcmatch_array
  end interface
  integer :: ncells
contains
  function bcmatch_array(face)
    integer, intent(in) :: face
    integer :: bcmatch_array(ncells)
    bcmatch_array = 0
  end function
end module

module bc_data_module
  integer :: bc_mat
end module

module bc_module  ! exports BC_MAT
  use bc_data_module  ! imports BC_MAT
  use bc_info_module, only: bcmatch
  private
  public :: bc_mat
end module

module property_module
  use bc_module, only: bc_mat
end module
