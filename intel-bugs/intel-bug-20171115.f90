!! Compiler fails to correctly interpret type declaration with multiple components.
!! This is a variation of intel-bug-20171018.f90 (fixed in 18.0.1) that makes
!! TOOLPATH an extension of another type.  This has the same problem.
!!
!! $ ifort --version intel-bug-20171115.f90 
!! ifort (IFORT) 18.0.1 20171018
!! 
!! $ ifort -c intel-bug-20171115.f90 
!! intel-bug-20171115.f90(25): error #6404: This name does not have a type, and must have an explicit type.   [LAST]
!!     type(path_segment), pointer :: first => null(), last => null(), curr => null()
!! ----------------------------------------------------!! 
!! intel-bug-20171115.f90(25): error #6404: This name does not have a type, and must have an explicit type.   [FIRST]
!!     type(path_segment), pointer :: first => null(), last => null(), curr => null()
!! -----------------------------------!! 
!! compilation aborted for intel-bug-20171115.f90 (code 1)

module example

  implicit none

  type, abstract :: path
  end type
  
  type, extends(path), public :: toolpath
    type(path_segment), pointer :: first => null(), last => null(), curr => null()
  end type

  type :: path_segment
  end type

end module
