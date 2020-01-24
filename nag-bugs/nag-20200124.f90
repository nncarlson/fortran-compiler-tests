!! SR104818
!!
!! GENERIC FUNCTION LOSES CONTIGUOUS ATTRIBUTE
!!
!! The following example shows that the CONTIGUOUS attribute of an
!! array pointer valued function is not being propagated to the
!! generic function for which it is a specific procedure in some
!! contexts. The error occurs for both 6.2 and 7.0, but not 6.1
!!
!! $ nagfor -w nag-20200124.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6253
!! Error: nag-20200124.f90, line 34: Argument DP (no. 1) of FOO is a CONTIGUOUS
!!                    pointer, but the actual argument is not simply contiguous
!! [NAG Fortran Compiler error termination, 1 error, 1 warning]
!!

module contig_generic_ptr_func

  interface dataptr
    procedure dataptr1
  end interface

contains

  function dataptr1() result(dp)
    real, pointer, contiguous :: dp(:)
    allocate(dp(10))
  end function

end module

use contig_generic_ptr_func
real, pointer, contiguous :: x(:)
x => dataptr()        ! NO ERROR HERE
call foo(dataptr1())  ! NO ERROR HERE
call foo(dataptr())   ! BUT ERROR HERE
contains
  subroutine foo(dp)
    real, pointer, contiguous :: dp(:)
  end subroutine
end
