!!
!! The NAG Fortran compiler generates invalid intermediate C code for the
!! following example.
!!
!! $ nagfor -c nag-bug-20170805-2.f90 
!! NAG Fortran Compiler Release 6.1(Tozai) Build 6136
!! [NAG Fortran Compiler normal termination]
!! nag-bug-20170805-2.f90:4:3: error: expected specifier-qualifier-list before `__NAGf90_ChDope4'
!!  !!
!!    ^               
!! nag-bug-20170805-2.f90:1:8: error: unknown type name `__NAGf90_ChDope4'
!!  !!
!!         ^               
!! nag-bug-20170805-2.f90:41:18: error: conflicting types for `my_mod_MP_dataptr'
!!    function dataPtr(this) result(dp)
!!                   ^~~~~~~~~~~~~~~~~
!! nag-bug-20170805-2.f90:1:25: note: previous declaration of `my_mod_MP_dataptr' was here
!!  !!
!!                          ^                

module my_mod

  use iso_c_binding

  type my_type
    type(c_ptr) :: obj
  contains
    procedure :: dataPtr
  end type

  interface
    subroutine get_dataptr(obj, cp) bind(c)
      import
      type(c_ptr), value :: obj
      type(c_ptr) :: cp
    end subroutine
  end interface

contains

  function dataPtr(this) result(dp)
    class(my_type) :: this
    character, pointer :: dp(:,:,:,:)
    type(c_ptr) :: cp
    call get_dataptr(this%obj, cp)
    call c_f_pointer(cp, dp, shape=[2,2,2,2])
  end function

end module

!! This minimal example produces the same errors from the C compiler albeit with
!! Fortran compiler warnings about unused argument and undefined function result.

!module my_mod_min
!
!  type my_type
!  contains
!    procedure :: dataPtr
!  end type
!
!contains
!
!  function dataPtr(this) result(dp)
!    class(my_type) :: this
!    character, pointer :: dp(:,:,:,:)
!  end function
!
!end module

