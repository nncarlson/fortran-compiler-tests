!!
!! SYNOPSIS: Keyword arguments not working for generic TBP
!!
!! The following example defines a derived data type with a generic
!! type-bound procedure.  The Intel ifort compiler reports an error
!! when the procedure is invoked through an instance of the type using
!! keyword arguments, complaining that an explicit interface is required.
!! This is erroneous; the interface to the generic (and its specifics)
!! are all explicit.
!!
!! % ifort --version
!! ifort (IFORT) 12.0.3 20110309
!!
!! % ifort bug-20110404.f90 
!! bug-20110404.f90(44): error #6632: Keyword arguments are invalid without an explicit interface.   [B]
!!   call x%bar (b=1, a=2)
!! --------------!! 
!! bug-20110404.f90(44): error #6632: Keyword arguments are invalid without an explicit interface.   [A]
!!   call x%bar (b=1, a=2)
!! -------------------!! 
!! compilation aborted for bug-20110404.f90 (code 1)
!!

module mod
  private     ! removing this doesn't help (and isn't necessary)
  type, public :: foo
    integer :: a, b
  contains
    private   ! removing this doesn't help (and isn't necessary)
    procedure :: bar1
    generic, public :: bar => bar1
  end type
contains
  subroutine bar1 (this, a, b)
    class(foo) :: this
    integer :: a, b
    this%a = a
    this%b = b
  end subroutine
end module

program main
  use mod
  type(foo) :: x
  call x%bar (b=1, a=2)
end program
  
  
    
