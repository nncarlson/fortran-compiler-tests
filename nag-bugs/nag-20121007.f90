!! fixed in 5.3.1 (906)
!!
!! In the example below, the specific binding for the type-bound assignment
!! does not have the object passed as one of the arguments (NOPASS).  This
!! violates C468 (R450): "If generic-spec is not generic-name, each of its
!! specific bindings shall have a passed-object dummy argument (4.5.4.5)."
!! The NAG compiler lets this slip past without error.  (The defined
!! assignment does work as expected, however.)
!!
!! % nagfor -version
!! NAG Fortran Compiler Release 5.3.1 pre-release(904)
!! 
!! % nagfor -c nag-bug-20121007.f90 
!! NAG Fortran Compiler Release 5.3.1 pre-release(904)
!! [NAG Fortran Compiler normal termination]
!!

module example

  type :: some_type
    integer :: n
  contains
    procedure, nopass, private :: copy
    generic :: assignment(=) => copy
  end type
  
contains

  subroutine copy (a, b)
    class(some_type), intent(inout) :: a
    class(some_type), intent(in) :: b
    a%n = b%n
  end subroutine
  
end module
