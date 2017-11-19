!!
!! DEFINED STRUCTURE CONSTRUCTOR HIDES DERIVED TYPE
!!
!! The following example defines a derived type which is imported into a later
!! subroutine and used.  A F2003 structure constructor is also defined for the
!! derived type, however this causes the compiler to "forget" the definition
!! of the derived type, because in the use'ing subroutine it claims (incorrectly)
!! that the type is unknown.  This occurs with Intel 14.0.3 and 15.0.2 compilers.
!!
!! % ifort --version
!! ifort (IFORT) 15.0.2 20150121
!! 
!! % ifort -c intel-bug-20150531.f90 
!! intel-bug-20140531.f90(49): error #6463: This is not a derived type name.   [A]
!!   type(A) :: x  ! BUT THE COMPILER COMPLAINS HERE THAT A IS NOT A DERIVED TYPE
!! -------^
!! intel-bug-20150531.f90(50): error #6633: The type of the actual argument differs from the type of the dummy argument.   [X]
!!   call bar (x)
!! ------------^
!! compilation aborted for intel-bug-20150531.f90 (code 1)
!!

module A_type
  type :: A
    character(:), allocatable :: name
  end type
  interface A
    procedure defined_constructor
  end interface
contains
  function defined_constructor (name) result (A_obj)
    character(*), intent(in) :: name
    type(A) :: A_obj
    A_obj%name = name
  end function
end module

module foo
contains
  subroutine bar (x)
    use A_type
    type(A) :: x
  end subroutine
end module

subroutine fubar
  use A_type    ! THIS DEFINES THE DERIVED TYPE A
  use foo
  type(A) :: x  ! BUT THE COMPILER COMPLAINS HERE THAT A IS NOT A DERIVED TYPE
  call bar (x)
end subroutine
