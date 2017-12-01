!Issue number DPD200357444
!!
!! ELEMENTAL FUNCTION RETURNS INCORRECT RESULT
!!
!! In the following example the elemental function returns the
!! incorrect result when used with a scalar argument
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort intel-bug-20140610.f90 
!! % ./a.out
!!  XXXXX (expect "XXXXX")
!!  fubar (expect "XXXXX")  <== INCORRECT RESULT
!!  XX (expect "XX")
!!

module string_utilities
contains

  function raise_case (s) result (ucs)
    character(*), intent(in) :: s
    character(len(s)) :: ucs
    ucs = repeat('X',len(s)) ! ignore S and just assign fixed string
  end function
  
  elemental function elem_raise_case (s) result (ucs)
    character(*), intent(in) :: s
    character(len(s)) :: ucs
    ucs = repeat('X',len(s)) ! ignore S and just assign fixed string
  end function
  
  function string ()
    character(:), allocatable :: string
    string = 'fubar'
  end function
end module

program example
  use string_utilities
  print *, raise_case(string()), ' (expect "XXXXX")'       ! CORRECT RESULT
  print *, elem_raise_case(string()), ' (expect "XXXXX")'  ! GIVES WRONG RESULT
  print *, elem_raise_case(['a','z']), ' (expect "XX")'    ! BUT THIS IS CORRECT
end program
