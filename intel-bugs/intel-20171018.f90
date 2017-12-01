!! Compiler fails to correctly interpret type declaration with multiple components.
!!
!! $ ifort --version -c intel-bug-20171018.f90
!! ifort (IFORT) 18.0.0 20170811
!! 
!! $ ifort -c intel-bug-20171018.f90
!! intel-bug-20171018.f90(20): error #6404: This name does not have a type, and must have an explicit type.   [LAST]
!!     type(path_segment), pointer :: first => null(), last => null(), curr => null()
!! ----------------------------------------------------^
!! intel-bug-20171018.f90(20): error #6404: This name does not have a type, and must have an explicit type.   [FIRST]
!!     type(path_segment), pointer :: first => null(), last => null(), curr => null()
!! -----------------------------------^
!! compilation aborted for intel-bug-20171018.f90 (code 1)

module example

  implicit none

  type, public :: toolpath
    type(path_segment), pointer :: first => null(), last => null(), curr => null()
  end type

  type :: path_segment
  end type

end module
