!! IEEE_SUPPORT_HALTING IN CONSTANT EXPRESSION
!!
!! The NAG 6.2 compiler gives this error for the following program
!!
!! $ nagfor nag-20180203d.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Error: nag-20180203d.f90, line 16: Reference to non-intrinsic function
!! IEEE_SUPPORT_HALTING_X via generic IEEE_SUPPORT_HALTING in constant expression
!!
!! I do not think this is correct. A constant expression may be a specification
!! inquiry.  7.1.11,4: "A specification inquiry is a reference to (3) an inquiry
!! function from the intrinsic modules [...] and IEEE EXCEPTIONS".  And
!! Table 14.2 lists IEEE_SUPPORT_HALTING as an inquiry function.
!!

use ieee_exceptions
logical, parameter :: foo = ieee_support_halting(ieee_invalid)
end
