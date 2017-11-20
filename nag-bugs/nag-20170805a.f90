!!
!! The IMPLICIT NONE statement causes the compiler to regard C_INT in the
!! function declaration as undeclared even though its definition is imported
!! into the function scope by the IMPORT statement.
!!
!! Same erroneous behavior if the IMPLICIT NONE is removed and the "-u"
!! compile option used.
!!
!! $ nagfor -c nag-bug-20170805.f90
!! NAG Fortran Compiler Release 6.1(Tozai) Build 6136
!! Error: nag-bug-20170805.f90, line 21: Implicit type for C_INT in FOO
!!        detected at IMPLICIT@NONE
!! [NAG Fortran Compiler pass 1 error termination, 1 error]
!!

program main
  use iso_c_binding
  interface
    integer(c_int) function foo() bind(c)
      import
      implicit none
    end function
  end interface
  print *, foo()
end program
