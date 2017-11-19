!!
!! REGRESION IN 14.0.1 AGAINST 14.0.0 AND 13.x
!!
!! The following stripped-down reproducer compiles without error using 14.0.0
!! and the 13.x compiler versions, but the 14.0.1 compiler issues an error:
!!
!! $ ifort --version
!! ifort (IFORT) 14.0.1 20131008
!! $ ifort -c intel-bug-20140109.f90 
!! intel-bug-20140109.f90(80): error #6401: The attributes of this name conflict with those made accessible by a USE statement.   [SIZE]
!!     n = size(T2obj) ! THE COMPILER COMPLAINS ABOUT THE ATTRIBUTES OF THE 'SIZE' NAME
!! --------^
!!
!! The error is incorrect.  T1mod defines a generic interface SIZE for TYPE(T1)
!! arguments, and T2mod, which uses T1mod, extends that interface for TYPE(T2)
!! arguments.  There is no conflict as claimed.  T1mod also defines a couple of
!! completely extraneous generic interfaces, however if any one of these are
!! removed from the example it compiles without error.  Further, if either of
!! the public statements is removed (they are redundant -- all entities are
!! public) the example compiles without error.
!!

module T1mod

  type T1
    integer, pointer :: array(:)
  end type

  interface size
    module procedure T1size
  end interface

  interface generic1
    module procedure sub1
  end interface

  interface generic2
    module procedure sub2
  end interface

contains

  integer function T1size (AtlasData)
    type(T1), intent(IN) :: AtlasData
    T1size = 0
  end function

  subroutine sub1 (T1obj, size)
    type(t1) :: t1obj
    integer :: size
  end subroutine

  subroutine sub2 (T1obj, rank)
    type(T1) :: T1obj
    integer :: rank(size(T1obj%array))
  end subroutine

end module

module T2mod

  use T1mod

  public :: generic1
  public :: generic2

  type T2
    integer :: n
  end type

  interface size
     module procedure T2size
  end interface

contains

  integer function T2size (T2obj)
    type(T2) :: T2obj
    T2size = T2obj%n
  end function

  subroutine sub3 (T2obj)
    type(T2) :: T2obj
    n = size(T2obj) ! THE COMPILER COMPLAINS ABOUT THE ATTRIBUTES OF THE 'SIZE' NAME
  end subroutine

end module
