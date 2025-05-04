!! https://github.com/flang-compiler/flang/issues/313
!!
!! $ flang -c flang-20171123a.f90 
!! F90-S-0142-size is not a component of this OBJECT (flang-20171123a.f90: 17)
!! F90-S-0075-Subscript, substring, or argument illegal in this context for size (flang-20171123a.f90: 17)
!! F90-S-0155-FUNCTION may not be declared character*(*) when in an INTERFACE - foo_func (flang-20171123a.f90: 14)
!!   0 inform,   0 warnings,   3 severes, 0 fatal for example
!!
!! The first error message concerning the declaration of STRING is erroneous.

module example

  type, abstract :: foo
  contains
    procedure(foo_size), deferred :: size 
    procedure(foo_func), deferred :: func
  end type
  
  abstract interface
    pure integer function foo_size (this)
      import foo
      class(foo), intent(in) :: this
    end function
    function foo_func (this) result (string)
      import :: foo
      class(foo) :: this
      character(this%size()) :: string
    end function
  end interface

end module
