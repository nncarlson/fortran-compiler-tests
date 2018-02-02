!! The presence of the external function FOO seems to be confusing
!! the NAG compiler when it gets to the interface block within the
!! main program.  That should define a local FOO procedure, having
!! nothing to do with the external FOO, which binds to the external
!! BAR procedure.  The error goes away if the external FOO procedure
!! is commented out
!!
!! $ nagfor nag-20180202b.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Error: nag-20180202b.f90: INTERFACE block for FOO from MAIN should not have the BIND(C) attribute
!! Error: nag-20180202b.f90: Wrong number of arguments to FOO from MAIN: 1 found, 0 expected
!! [NAG Fortran Compiler error termination, 2 errors]
!!
!! I see no constrain in the F08 standard that prohibits a BIND
!! attribute on an interface block procedure.
!!

integer function foo(x)
  integer :: x
  foo = 2+0*x
end function

integer function bar() bind(c)
  bar = 1
end function

program main
  interface
    integer function foo() bind(c,name='bar')
    end function
  end interface
  if (foo() /= 1) stop 1
end program
