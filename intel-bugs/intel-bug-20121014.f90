!Issue number DPD200237446
!!
!! BAD OBJECT CODE FOR USER-DEFINED CONSTRUCTOR/ASSIGNMENT
!!
!! The following code executes an intrinsic assignment of a derived type, and
!! the right hand side expression is a user-defined constructor (see FUBAR).
!! That assignment is equivalent to a pointer assignment.  Yet with the Intel
!! 13.0.0 compiler the pointer component of the left hand side is not pointer
!! assigned as it should be.  Note the unreferenced_subroutine; if this
!! procedure is removed from the code, it runs correctly.  Alternatively,
!! if the allocatable class(*) component of typeA is replaced with a
!! non-polymorphic component (e.g., integer :: value) the code also runs
!! correctly.
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! 
!! % ifort intel-bug-20121014.f90 
!! 
!! % ./a.out
!!  d%b%pA associated? (expect T) T
!!  doing the equivalent of c%pA => d%b%pA
!!  c%pA associated? (expect T) F
!!                             ^^^  THIS IS WRONG!

module mod

  type :: typeA
    class(*), allocatable :: value  ! ALLOCATABLE CLASS(*) ESSENTIAL TO ERROR
  end type

  type :: typeB
    type(typeA), pointer :: pA => null()
  end type

  type :: typeC
    class(typeA), pointer :: pA => null()
  end type

  !! User-defined typeC constructor
  interface typeC
    procedure typeC_constructor
  end interface

  type :: typeD
    type(typeB) :: b
  end type
  
contains

  function typeC_constructor (b) result (c)
    class(typeB), intent(in) :: b
    type(typeC) :: c
    c%pA => b%pA
  end function

  !! IF THIS UNUSED PROCEDURE IS REMOVED, CORRECT RESULTS ARE OBTAINED!
  subroutine unreferenced_subroutine (c, d)
    type(typeC), intent(out) :: c
    class(typeD), intent(in) :: d
    c = typeC(d%b)
  end subroutine
  
  subroutine fubar
  
    type(typeD) :: d
    type(typeC) :: c
    
    allocate(d%b%pA)
    print *, 'd%b%pA associated? (expect T)', associated(d%b%pA)
    
    print *, 'doing the equivalent of c%pA => d%b%pA'
    c = typeC(d%b)  ! THIS STATEMENT IS EQUIVALENT TO c%pA => d%b%pA
    
    print *, 'c%pA associated? (expect T)', associated(c%pA)
    if (associated(c%pA)) then
      print *, 'c%pA and d%b%pA associated? (expect T) ', associated(c%pA, d%b%pA)
    end if

  end subroutine

end module

program main
  use mod
  call fubar
end program

