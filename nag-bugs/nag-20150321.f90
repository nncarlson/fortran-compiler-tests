!! fixed in 6.0 (1042)
!!
!! BAD INTERMEDIATE C CODE GENERATED
!!
!! The gcc compiler chokes on the intermediate C code that the
!! NAG compiler (6.0 edit 1037, 5.3.2 edit 990) generates from
!! the following example.  Here is the output
!!
!! From 6.0:
!! % nagfor nag-bug-20150321.f90 
!! NAG Fortran Compiler Release 6.0(Hibiya) Build 1037
!! [NAG Fortran Compiler normal termination]
!! nag-bug-20150321.f90:30:8: error: empty scalar initializer
!!  module M4
!!         ^
!! nag-bug-20150321.f90:30:8: error: (near initialization for `m4_MP_fubar.e_')
!!
!! From 5.3.2:
!! % nagfor nag-bug-20150321.f90 
!! NAG Fortran Compiler Release 5.3.2(990)
!! [NAG Fortran Compiler normal termination]
!! nag-bug-20150321.f90:30:8: warning: braces around scalar initializer [enabled by default]
!!  module M4
!!         ^
!! nag-bug-20150321.f90:30:8: warning: (near initialization for `m4_MP_fubar.e_') [enabled by default]
!! nag-bug-20150321.f90:30:8: warning: braces around scalar initializer [enabled by default]
!! nag-bug-20150321.f90:30:8: warning: (near initialization for `m4_MP_fubar.e_') [enabled by default]
!! nag-bug-20150321.f90:30:8: error: empty scalar initializer
!! nag-bug-20150321.f90:30:8: error: (near initialization for `m4_MP_fubar.e_')
!! nag-bug-20150321.f90:30:8: warning: braces around scalar initializer [enabled by default]
!! nag-bug-20150321.f90:30:8: warning: (near initialization for `m4_MP_fubar.e_') [enabled by default]
!! nag-bug-20150321.f90:30:48: warning: initialization from incompatible pointer type [enabled by default]
!!  module M4
!!                                                 ^
!! nag-bug-20150321.f90:30:48: warning: (near initialization for `m4_MP_fubar.e_') [enabled by default]
!! nag-bug-20150321.f90:30:48: warning: excess elements in scalar initializer [enabled by default]
!! nag-bug-20150321.f90:30:48: warning: (near initialization for `m4_MP_fubar.e_') [enabled by default]
!!

module M1
  type T1
    integer :: a
  end type
end module

module M2
  use M1
  type :: T2
    type(T1), pointer :: b => null()
  end type
end module

module M3
  use M2
  type, public :: T3
    integer, allocatable :: c(:)
    type(T2) :: d
  end type
end module

module M4
  use M3
  type T4
    type(T3), allocatable :: e
  end type
  type(T4) :: fubar
end module
