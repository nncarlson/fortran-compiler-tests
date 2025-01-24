!! INVALID INTERMEDIATE C CODE WITH GCC 14
!!
!! The following example gives a C compiler error with nagfor 7.2.7221 and
!! gcc 14.2, but compiles fine with gcc 13 and earlier. The error can be
!! avoided using the nagfor option '-Wc,-Wno-incompatible-pointer-types'
!! to have gcc downgrade the error to a warning.
!!
!! $ nagfor -c nag-20250124.f90 
!! NAG Fortran Compiler Release 7.2(Shin-Urayasu) Build 7221
!! [NAG Fortran Compiler normal termination]
!! nag-20250124.f90: In function 'foo_':
!! nag-20250124.f90:28:6: error: assignment to 'float (*)(float)' from incompatible pointer type 'float (*)()' [-Wincompatible-pointer-types]
!!    28 |   call c_f_procpointer(funptr, fptr)
!!       |      ^

subroutine foo

  use,intrinsic :: iso_c_binding, only: c_funptr, c_f_procpointer

  abstract interface
    real function f(x) bind(c)
      real, value :: x
    end function
  end interface
  procedure(f), pointer :: fptr
  type(c_funptr) :: funptr

  call c_f_procpointer(funptr, fptr)

end subroutine
