!! SR99910. Fixed in 6.2 build 6207; 6.1 build 6148 (scheduled)
!!
!! INVALID INTERMEDIATE C CODE
!!
!! The NAG 6.1 and 6.2 compilers generate invalid intermediate
!! C code for the following example.
!!
!! $ nagfor nag-20180202c.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! [NAG Fortran Compiler normal termination]
!! nag-20180202c.f90: In function 'example_MP_foo':
!! nag-20180202c.f90:40:17: error: 'struct example_DT_myclass' has no member named 'sig'
!!      allocate(tmp, source=array(1))
!!                  ^
!! nag-20180202c.f90:40:42: error: 'struct example_DT_myclass' has no member named 'dtp'
!!      allocate(tmp, source=array(1))
!!                                           ^
!! nag-20180202c.f90:40:21: error: 'struct example_DT_myclass' has no member named 'sig'
!!      allocate(tmp, source=array(1))
!!                      ^
!! nag-20180202c.f90:40:14: error: 'pTmp1' is a pointer; did you mean to use '->'?
!!      allocate(tmp, source=array(1))
!!               ^
!!               ->
!! nag-20180202c.f90:40:14: error: 'struct example_DT_myclass' has no member named 'sig'
!!      allocate(tmp, source=array(1))
!!               ^
!! nag-20180202c.f90:40:35: error: 'struct example_DT_myclass' has no member named 'sig'
!!      allocate(tmp, source=array(1))
!!                                    ^

module example
  type, abstract :: myclass
  contains
    procedure, nopass :: foo
  end type
contains
  subroutine foo(array)
    class(myclass) :: array(:)
    class(myclass), allocatable :: tmp
    allocate(tmp, source=array(1))
  end subroutine
end module
