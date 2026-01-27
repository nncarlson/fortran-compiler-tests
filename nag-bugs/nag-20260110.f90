!! Fixed in 7.2.7243
!! REJECTS VALID CODE
!!
!! In this example an assumed-rank dummy is passed to a generic subroutine with
!! a matching specific with assumed-rank argument. When the generic is not
!! type bound, the subroutine call is resolved, but not when the generic is a
!! type bound procedure.
!!
!! $ nagfor -c nag-20260110.f90 
!! NAG Fortran Compiler Release 7.2(Shin-Urayasu) Build 7241
!! Warning: nag-20260110.f90, line 32: Unused dummy variable ARRAY
!! Warning: nag-20260110.f90, line 32: Unused dummy variable THIS
!! Warning: nag-20260110.f90, line 35: Unused dummy variable ARRAY
!! Error: nag-20260110.f90, line 45: No specific match for reference to generic type-bound procedure SUB
!! [NAG Fortran Compiler error termination, 1 error, 3 warnings]
!!

module foo_type
  ! A type-bound generic with assumed-rank argument
  type foo
  contains
    generic :: sub => sub1
    procedure :: sub1
  end type
  ! An unbound generic with assumed-rank argument
  interface sub
    procedure :: sub2, sub1
  end interface
contains
  subroutine sub1(this, array)
    class(foo) this
    real array(..)
  end subroutine
  subroutine sub2(array)
    real array(..)
  end subroutine
end module

use foo_type
type(foo) :: x
contains
  subroutine bar(array)
    real array(..)
    call sub(array)    ! THIS RESOLVES CORRECTLY,
    call sub(x, array) ! AND SO DOES THIS,
    call x%sub(array)  ! BUT THIS DOES NOT!
  end subroutine
end
