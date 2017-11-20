!! fixed in 6.0 (1052)
!!
!! ERROR PARSING KEYWORD ARGUMENT
!!
!! In the example below, the compiler takes spurious issue
!! with the assignment statement involving the intrinsic
!! elemental function IBSET.  It reports no error when
!! compiled with -O0, but an error with -O1 or -O2.  The
!! error appears to be coming from the backend C compiler.
!!
!! % nagfor -O2 -c nag-bug-20150520.f90 
!! NAG Fortran Compiler Release 6.0(Hibiya) Build 1049
!! [NAG Fortran Compiler normal termination]
!! nag-bug-20150520.f90: In function 'fubar_MP_foo':
!! nag-bug-20150520.f90:30:34: error: invalid operands to binary << (have 'int' and 'AAType1')
!!      arg%mask = ibset(arg%mask, pos=arg%pos)
!!                                  ^
!! Note that the error goes away if (unnnecessary) "pos=" keyword
!! specification is omitted. 
!!

module fubar
  type :: mytype
    integer, allocatable :: mask(:)
    integer, allocatable :: pos(:)
  end type
contains
  subroutine foo (arg)
    type(mytype) :: arg
    arg%mask = 0
    arg%mask = ibset(arg%mask, pos=arg%pos)
  end subroutine
end module
  
