!!
!! REJECTS VALID CODE
!!
!! The XL Fortran 16.1.1-rc3 compiler rejects the following code with the
!! error
!!
!! $ xlf ibm-20181203c.f90 
!! "ibm-20181203c.f90", line 26.15: 1514-433 (S) A non-intrinsic procedure referenced in a specification expression must be a specification function.
!! ** foo   === End of Compilation 1 ===
!! 1501-511  Compilation failed for file ibm-20181203c.f90.
!!
!! The non-intrinsic procedure referenced is OUTPUT_LENGTH, and it is very
!! clearly a specification function:
!!
!! F2008: 7.1.11 5) A function is a specification function if it is a pure
!! function, is not a standard intrinsic function, is not an internal function, is not
!! a statement function, and does not have a dummy procedure argument.
!!
!! Moreover OUTPUT_LENGTH(N) is a valid specification expression.
!!

module foo
contains
  pure function i_to_c(n) result(output)
    integer, intent(in) :: n
    character(output_length(n)) :: output
    output = 'foo'
  end function
  pure integer function output_length(n)
    integer, intent(in) :: n
    output_length = 3
  end function
end module
