!! COMPILER REJECTS VALID CODE
!!
!! The compiler issues a strange error for this example: "Cannot set attribute
!! for derived type name EVENT". This appears to be connected to a reference
!! to the default constructor expression EVENT() in the CALL statement, which
!! is contained in a BLOCK construct. The example compiles without error if
!! the CALL is not contained in a BLOCK construct. This is a regression in 7.1;
!! the example compiles fine with 7.0.
!!
!! $ nagfor -c -w=all bug.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7101
!! Error: bug.f90, line 27: Cannot set attribute for derived type name EVENT
!!        detected at SUBROUTINE@<end-of-statement>
!! [NAG Fortran Compiler pass 1 error termination, 1 error, 1 warning]

module example

  type :: event
  end type

contains

  subroutine foo
    block
      call bar(event())
    end block
  end subroutine

  subroutine bar(e)
    class(event), intent(in) :: e
  end subroutine

end module
