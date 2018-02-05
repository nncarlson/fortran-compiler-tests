!! The IMPLICIT NONE statement causes the compiler to regard S in the function
!! declaration as undeclared even though its type is declared in the body of
!! the function.  This is eerily similar to SR98771 which I reported (and NAG
!! fixed for 6.1) back in Aug '17.
!!
!! $ nagfor -c nag-20180203e.f90
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Error: nag-20180203e.f90, line 16: Implicit type for S
!!        detected at (@S
!! Error: nag-20180203e.f90, line 17: Symbol S has already been implicitly typed
!!        detected at S@<end-of-statement>

module mod
  implicit none
contains
  character(len(s)) function foo(s)
    character(*), intent(in) :: s
    foo = s
  end function
end module
