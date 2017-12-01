!!
!! BOGUS COMPILER ERROR
!!
!! The Intel 14.0.2 compiler is incorrectly reporting an error for a reference
!! to the intrinsic size function.  It appears to have confused it with another
!! size function.  However, no such function is defined within the scope of the
!! reference.  There appears to be lots of extraneous code that could be deleted,
!! but the error disappears if the example is trimmed down further.
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort -c intel-bug-20140609.f90 
!! intel-bug-20140609.f90(100): error #6402: prPromoteSym : Illegal KIND & CLASS mix   [SIZE]
!!     n = size(array) ! <== COMPILER IS TOTALLY CONFUSED HERE
!! --------^
!! intel-bug-20140609.f90(100): error #7021: Name invalid in this context   [SIZE]
!!     n = size(array) ! <== COMPILER IS TOTALLY CONFUSED HERE
!! --------^
!! compilation aborted for intel-bug-20140609.f90 (code 1)
!!

!! Exports type T1 with type bound procedure SIZE
module modT1
  private
  type, public :: T1
  contains
    procedure :: size => T1_size
  end type
contains
  integer function T1_size (this)
    class(T1) :: this
    T1_size = 0
  end function
end module

!! Exports type T2 and == operator for T2 objects
module modT2
  private
  type, public :: T2
    integer, pointer :: bar(:)
  end type
  public :: operator(.eq.)
  interface operator(.eq.)
    module procedure T2_eq
  end interface
contains
  logical function T2_eq (a, b)
    type(T2), intent(in) :: a, b
    T2_eq = (size(a%bar) == size(b%bar))
  end function
end module

!! Exports type T3 and adds T3-specific for generic SIZE function
module modT3
  private
  type, public :: T3
    integer :: n
  end type
  public :: size
  interface size
    module procedure T3_size
  end interface
contains
  integer function T3_size (this)
    type(T3) :: this
    T3_size = 0
  end function
end module

!! Exports SUBA1 only.  The scope of the USEd entities from MODT2
!! and MODT3 is limited to the body of SUBA1; they are not visible
!! within the module as a whole.
module modA
  private
  public subA1
contains
  subroutine subA1
    use modT2
    use modT3
  end subroutine
  subroutine subA2
  end subroutine
end module

!! Here is where the wheels come off.  The compiler does not
!! recognize the reference to the size function as being the
!! intrinsic SIZE, but appears to mistake it for something
!! else.  There is absolutely nothing in the scope of the
!! module or the SUB2 procedure that should account for that.
module fubar
contains
  subroutine sub1
    use modA  ! imports only SUBA1
    call subA1
  end subroutine
  subroutine sub2
    use modT1 ! imports only the type T1 (unused!)
    integer array(5)
    n = size(array) ! <== COMPILER IS TOTALLY CONFUSED HERE
  end subroutine
end module
