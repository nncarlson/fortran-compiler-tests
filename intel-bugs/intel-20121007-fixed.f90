!Issue number DPD200237122
!!
!! ASSOCIATING ENTITY IN SELECT-TYPE MISSING TARGET ATTRIBUTE
!!
!! In the following example a function returning a pointer to an unlimited
!! polymorphic variable is used as the selector in a SELECT TYPE construct.
!! By R602/C602 the selector is a variable and has the pointer attribute,
!! and as a consequence the associating entity UPTR should have the target
!! attribute, for it says in 8.1.3.3, "The associating entity has the TARGET
!! attribute if and only if the selector is a variable and has either the
!! TARGET or POINTER attribute."  The Intel 13.0.0 compiler is incorrect,
!! then, when it rejects the pointer assignment BAR => UPTR.
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! 
!! intel-bug-20121007-fixed.f90(44): error #6796: The variable must have the TARGET attribute or be a subobject of an object with the TARGET attribute, or it must have the POINTER attribute.   [UPTR]
!!     int_bar => uptr
!! ---------------^
!! intel-bug-20121007-fixed.f90(46): error #6796: The variable must have the TARGET attribute or be a subobject of an object with the TARGET attribute, or it must have the POINTER attribute.   [UPTR]
!!     foo_bar => uptr
!! ---------------^
!! compilation aborted for intel-bug-20121007-fixed.f90 (code 1)
!!

module mod
  type :: foo
    integer :: n
  end type
  type(foo), target :: obj = foo(1)
contains
  function return_uptr () result (uptr)
    class(*), pointer :: uptr
    uptr => obj
  end function
end module

program main
  use mod
  integer, pointer :: int_bar
  type(foo), pointer :: foo_bar
  select type (uptr => return_uptr())
  type is (integer)
    int_bar => uptr
  class is (foo)
    foo_bar => uptr
  end select
end program
  
