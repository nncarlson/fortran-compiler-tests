!!https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110224
!!
!! VALID CODE REJECTED
!!
!! According to 9.2 of the F18 standard, the function reference x%VAR_PTR()
!! is a variable and can appear in variable definition contexts, in particular
!! as the selector in an associate construct (11.1.3.1, C1101)
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 13.1.0
!! 
!! $ gfortran gfortran-20230612.f90 
!! gfortran-20230612.f90:18:4:
!! 
!!    18 |     var = 1.0
!!       |    1
!! Error: 'var' at (1) associated to expression cannot be used in a variable definition context (assignment)
!!

module mod
  type :: foo
    real, pointer :: var
  contains
    procedure :: var_ptr
  end type
contains
  function var_ptr(this) result(ref)
    class(foo) :: this
    real, pointer :: ref
    ref => this%var
  end function
end module
program main
  use mod
  type(foo) :: x
  associate (var => x%var_ptr())
    var = 1.0
  end associate
  x%var_ptr() = 2.0
end program
