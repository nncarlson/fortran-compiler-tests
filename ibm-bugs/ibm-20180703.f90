!! VALID SPECIFICATION FUNCTION NOT RECOGNIZED AS SUCH
!!
!! $ xlf2008 -qversion                                        
!! IBM XL Fortran for Linux, V16.1.1 (Beta 2)
!! Version: 16.01.0001.0000
!! 
!! $ xlf2008 -c ibm-20180703.f90                              
!! "ibm-20180703.f90", line 30.19: 1514-433 (S) A non-intrinsic procedure
!! referenced in a specification expression must be a specification function.
!! ** example   === End of Compilation 1 ===
!! 1501-511  Compilation failed for file ibm-20180703.f90.
!!
!! This is a spurious error.
!!
!! According to 7.1.11 par 5 (F2008) output_length is a specification function.
!! It is pure, not a standard intrinsic, not internal, and has no procedure
!! argument. Furthermore, output_length(n) is valid specification expression,
!! as the non-optional, intent(in) dummy argument is a restricted expression
!! by par 2 (11) and par 2 (2).
!! 
!! This example arises from string_utilities.F90 of Truchas.
!!

module example

contains

  function i_to_c(n) result(s)
    integer, intent(in) :: n
    character(len=output_length(n)) :: s
    s = ''
  end function

  pure integer function output_length(n)
    integer, intent(in) :: n
    output_length = 1
  end function

end module
