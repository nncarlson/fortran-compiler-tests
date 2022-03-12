!!
!! BAD INTERMEDIATE C CODE
!!
!! The NAG 6.1 (edit 6144) generates bad intermediate C code for the
!! following example.  Note that the error goes away if the dummy
!! argument X is made a scalar.
!!
!! $ nagfor -c nag-20180127a.f90 
!! NAG Fortran Compiler Release 6.1(Tozai) Build 6144
!! [NAG Fortran Compiler normal termination]
!! nag-20180127a.f90: In function 'mod_MP_bar':
!! nag-20180127a.f90:15:17: error: 'struct mod_DT_foo' has no member named 'sig'
!!      allocate(y, source=x(1))
!!                  ^
!! nag-20180127a.f90:15:42: error: 'struct mod_DT_foo' has no member named 'dtp'
!!      allocate(y, source=x(1))
!!                                           ^
!! nag-20180127a.f90:15:19: error: 'struct mod_DT_foo' has no member named 'sig'
!!      allocate(y, source=x(1))
!!                    ^
!! nag-20180127a.f90:15:14: error: 'pTmp1' is a pointer; did you mean to use '->'?
!!      allocate(y, source=x(1))
!!               ^
!!               ->
!! nag-20180127a.f90:15:14: error: 'struct mod_DT_foo' has no member named 'sig'
!!      allocate(y, source=x(1))
!!               ^
!! nag-20180127a.f90:15:35: error: 'struct mod_DT_foo' has no member named 'sig'
!!      allocate(y, source=x(1))
                                   ^

module mod
  type, abstract :: foo
  contains
    procedure, nopass :: bar
  end type
contains
  subroutine bar(x)
    class(foo) :: x(:)
    class(foo), allocatable :: y
    allocate(y, source=x(1))
  end subroutine
end module
