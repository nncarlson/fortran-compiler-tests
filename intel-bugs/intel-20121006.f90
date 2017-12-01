!Issue number DPD200237117
!! INCORRECT CODE ANALYSIS
!!
!! The Intel 13.0.0 compiler incorrectly analyzes the following standard-
!! conforming code.  Three essentially identical functions that return a
!! a derived type result are defined.  A defined-constructor for the type
!! is declared using the second, and a generic interface is declared for
!! the third.  In both these cases the compiler asserts that the return
!! value of the associated functions has not been defined; this is incorrect.
!! Note that no error is asserted for the first function.
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! Copyright (C) 1985-2012 Intel Corporation.  All rights reserved.
!! 
!! % ifort -c intel-bug-20121006.f90 
!! intel-bug-20121006.f90(47): warning #6178: The return value of this FUNCTION has not been defined.   [F2]
!!   function f2 ()
!! -----------^
!! intel-bug-20121006.f90(52): warning #6178: The return value of this FUNCTION has not been defined.   [F3]
!!   function f3 ()
!! -----------^
!!

module example

  type :: some_type
    integer :: n
  end type
  
  !! Defined constructor for SOME_TYPE
  interface some_type
    procedure f2
  end interface
  
  !! Generic interface
  interface generic_name
    procedure f3
  end interface
  
contains

  function f1 ()
    type(some_type) :: f1
    f1%n = 1
  end function
  
  function f2 ()
    type(some_type) :: f2
    f2%n = 1
  end function
  
  function f3 ()
    type(some_type) :: f3
    f3%n = 1
  end function
  
end module
