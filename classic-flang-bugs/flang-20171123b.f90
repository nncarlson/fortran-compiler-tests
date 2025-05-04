!! https://github.com/flang-compiler/flang/issues/314
!!
!! ILLEGAL AMBIGUOUS TYPE BOUND GENERICS NOT DETECTED 
!!
!! The does not detect when illegal ambiguous type bound generic functions are
!! defined.  The following example defines a type FOO with type-bound generic
!! name, assignment, and operator. An extended type BAR adds to these generics,
!! but the pair of specific bindings for each of the three generics are
!! ambiguous according to the rules given in 12.4.3.4.5 (see also C.9.6 par 3).
!!
!! % flang -c flang-20171123b.f90
!! (no errors reported)
!!

module ambiguous_generics

  type :: foo
  contains
    procedure :: foo_print
    generic :: print => foo_print
    procedure :: foo_copy
    generic :: assignment(=) => foo_copy
    procedure :: foo_plus
    generic :: operator(+) => foo_plus
  end type
  
  type, extends(foo) :: bar
  contains
    procedure :: bar_print
    generic :: print => bar_print
    procedure :: bar_copy
    generic :: assignment(=) => bar_copy
    procedure :: bar_plus
    generic :: operator(+) => bar_plus
  end type
  
contains

  subroutine foo_print (this)
    class(foo) :: this
  end subroutine

  subroutine bar_print (this)
    class(bar) :: this
  end subroutine
  
  subroutine foo_copy (lhs, rhs)
    class(foo), intent(inout) :: lhs
    class(foo), intent(in) :: rhs
  end subroutine
  
  subroutine bar_copy (lhs, rhs)
    class(bar), intent(inout) :: lhs
    class(bar), intent(in) :: rhs
  end subroutine
  
  function foo_plus (a, b) result (c)
    class(foo), intent(in) :: a, b
    class(foo), allocatable :: c
    allocate(c, mold=a)
  end function
  
  function bar_plus (a, b) result (c)
    class(bar), intent(in) :: a, b
    class(bar), allocatable :: c
    allocate(c, mold=a)
  end function
  
end module
