!Issue number DPD200237118
!!
!! SELECTOR IN SELECT-TYPE NOT RECOGNIZED AS POLYMORPHIC
!!
!! In the following example a (type-bound) function returning a pointer to an
!! unlimited polymorphic variable is used as the selector in a SELECT TYPE
!! construct.  When the function is invoked directly, the Intel 13.0.0 compiler
!! correctly recognizes the selector as being polymorphic.  But when the
!! function is invoked through an object, the compiler fails to recognize it
!! as polymorphic, which is incorrect.
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! 
!! % ifort -c intel-bug-20121006a-fixed.f90
!!intel-bug-20121006a-fixed.f90(52): error #8247: Selector in SELECT TYPE statements must be polymorphic value.
!!  select type (uptr => foo%return_uptr())
!!--^
!!compilation aborted for intel-bug-20121006a-fixed.f90 (code 1)
!!

module typeA_def

  type :: typeA
    class(*), pointer :: uptr => null()
  contains
    procedure :: return_uptr
  end type

contains

  function return_uptr (this) result (uptr)
    class(typeA) :: this
    class(*), pointer :: uptr
    uptr => this%uptr
  end function
  
end module


program main

  use typeA_def
  type(typeA) :: foo
  
  !! SELECTOR IS CORRECTLY RECOGNIZED AS POLYMORPHIC
  select type (uptr => return_uptr(foo))
  class is (typeA)
  end select
  
  !! SELECTOR IS NOT RECOGNIZED AS POLYMORPHIC -- WRONG.
  select type (uptr => foo%return_uptr())
  class is (typeA)
  end select
  
end program
  
