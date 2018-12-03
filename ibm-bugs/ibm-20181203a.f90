!! REJECTS VALID CODE
!!
!! The xlf 16.1.1-rc3 compiler (power9) rejects the following valid example:
!!
!! $ xlf ibm-20181203a.f90
!! "ibm-20181203a.f90", line 35.14: 1513-061 (S) Actual argument attributes do not match those specified by an accessible explicit interface.
!! ** example   === End of Compilation 1 ===
!! 1501-511  Compilation failed for file ibm-20181203a.f90.
!!
!! If the NAME= specifier is removed from the definition of the actual
!! procedure argument the compiler accepts the code, so the compiler appears
!! to regard the presence (and value?) of the NAME specifier as part of the
!! characteristics of the procedure. This is incorrect. According to 12.2
!! (F2003, 12.3.1 F2008) only whether it has the BIND attribute is a
!! characteristic:
!!
!!   The characteristics of a procedure are the classification of the
!!   procedure as a function or subroutine, whether it is pure, whether
!!   it is elemental, whether it has the BIND attribute, the characteristics
!!   of its dummy arguments, and the characteristics of its result value if
!!   it is a function.
!!

module example

  abstract interface
    subroutine sighandler_t(signum) bind(c)
      integer, value :: signum
    end subroutine
  end interface

contains

  subroutine foo
    call bar(sighandler) ! SPURIOUS ERROR HERE
  end subroutine

  subroutine bar(proc)
    procedure(sighandler_t) :: proc
  end subroutine

  subroutine sighandler(signum) bind(c,name='')	! OKAY IF JUST BIND(C)
    integer, value :: signum
    print *, signum
  end subroutine sighandler

end module
