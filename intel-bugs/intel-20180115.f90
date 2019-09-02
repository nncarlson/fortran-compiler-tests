!! Support request 03209754: fixed in 19.0.4
!!
!! LENGTH PARAMETER NOT SET FOR POLYMORPHIC SELECT-TYPE SELECTOR
!!
!! In the following example a type bound function returning a pointer to an
!! unlimited polymorphic variable is used as the selector in a SELECT TYPE
!! construct.  When the dynamic type is CHARACTER, the length type of the
!! selector is not being set correctly.
!!
!! $ ifort --version
!! ifort (IFORT) 18.0.1 20171018
!!
!! $ ifort intel-20180115.f90
!! $ ./a.out
!! 0 ''
!!
!! The correct output is
!! 5 'fubar'
!!

module foo_type

  type :: foo
    class(*), pointer :: uptr => null()
  contains
    procedure :: return_uptr
  end type

contains

  function return_uptr(this) result(uptr)
    class(foo) :: this
    class(*), pointer :: uptr
    uptr => this%uptr
  end function

end module


program main

  use foo_type
  type(foo) :: x

  allocate(x%uptr, source='fubar')

  select type (uptr => x%return_uptr())
  type is (character(*))
    write(*,'(i0,1x,"''",a,"''")') len(uptr), uptr ! EXPECT 5 'fubar'
  end select

end program

