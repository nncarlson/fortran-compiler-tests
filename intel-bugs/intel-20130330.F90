!!
!! The following example shows two problems.  The first is an ICE:
!! 
!!   $ ifort --version
!!   ifort (IFORT) 13.1.1 20130313
!! 
!!   $ ifort -c -DSECOND_EXTENSION intel-bug-20130330.F90 
!!   /tmp/ifort0zik9G.i90: catastrophic error: **Internal compiler error: [...]
!!   compilation aborted for intel-bug-20130330.F90 (code 1)
!! 
!! If the definition of a second extended type is omitted then the compiler
!! terminates normally flagging, incorrectly I believe, an error in the code:
!!
!!   $ ifort -c intel-bug-20130330.F90 
!!   intel-bug-20130330.F90(38): error #8280: An overriding binding and its
!!   corresponding overridden binding must both be either subroutines or
!!   functions with the same result type, kind, and shape.   [FUNC]
!!       procedure         :: func => foo1_func
!!   -------------------------^
!!   compilation aborted for intel-bug-20130330.F90 (code 1)
!!
!! It is complaining about a mismatch in the result type, specifically a
!! mismatch in the length type parameter of the result.  The error message
!! is a paraphrase of an item from 4.5.7.3: "Either both shall be subroutines
!! or both shall be functions having the same result characteristics (12.3.3)."
!! The length is a type parameter of which 12.3.3 says: "If a type parameter
!! of a function result [...] is not a constant expression, the exact dependence
!! on the entities in the expression is a characteristic."  In this case the
!! length is declared using exactly the same specification expression, and thus
!! this characteristic of the two bindings is the same.
!!

module example

  ! Abstract base class with a tb function returning a character
  ! whose length is a specification expression.
  type, abstract :: foo
  contains
    procedure(foo_size), deferred, nopass :: size 
    procedure(foo_func), deferred         :: func
  end type
  
  abstract interface
    pure integer function foo_size ()
    end function
    function foo_func (this) result (string)
      import :: foo
      class(foo) :: this
      character(this%size()) :: string
    end function
  end interface
  
  !! Concrete implementation of the abstract base class
  type, extends(foo) :: foo1
  contains
    procedure, nopass :: size => foo1_size
    procedure         :: func => foo1_func
  end type

#ifdef SECOND_EXTENSION
  !! A second concrete implementation of the abstract base class
  type, extends(foo) :: foo2
  contains
    procedure, nopass :: size => foo2_size
    procedure         :: func => foo2_func
  end type
#endif

contains

  ! Serves the purpose of a type-bound parameter
  pure integer function foo1_size ()
    foo1_size = 6
  end function
  
  function foo1_func (this) result (string)
    class(foo1) :: this
    character(this%size()) :: string
    string = 'foobar'
  end function

#ifdef SECOND_EXTENSION
  ! Serves the purpose of a type-bound parameter
  pure integer function foo2_size ()
    foo2_size = 5
  end function
  
  function foo2_func (this) result (string)
    class(foo2) :: this
    character(this%size()) :: string
    string = 'fubar'
  end function
#endif

end module
