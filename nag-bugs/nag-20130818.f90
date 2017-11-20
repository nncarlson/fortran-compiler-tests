!!
!! BAD RUNTIME CHECK WITH -C
!!
!! With the "-C" compiler option, the following example gives a runtime error
!! stemming inside the call to FOO when a 0-length string is passed.  The
!! example runs as expected, without error, when the "-C" option is dropped.
!! Unless there is an exception for 0-length strings that I am not aware of,
!! this is valid code (see 12.5.2.11 -- a default character scalar may
!! correspond to an assumed-size character dummy array).
!!
!! % nagfor -C -gline nag-bug-20130818.f90 
!! NAG Fortran Compiler Release 5.3.2(961)
!! [NAG Fortran Compiler normal termination]
!! 
!! % ./a.out
!!  hello
!! Runtime Error: nag-bug-20130818.f90, line 37: Invalid reference to procedure MAIN:BAR - Actual argument for dummy argument ARRAY (number 1) is not an array
!! Program terminated by fatal error
!! nag-bug-20130818.f90, line 37: Error occurred in MAIN:BAR
!! nag-bug-20130818.f90, line 24: Called by MAIN:FOO
!! nag-bug-20130818.f90, line 28: Called by MAIN
!! Aborted (core dumped)
!!

program main

  call foo ('hello')  ! THIS WORKS FINE,
  call foo ('')       ! BUT THIS DOES NOT WITH "-C"
    
contains
  
  subroutine foo (string)
    character(*), intent(in) :: string
    call bar (string, len(string))
  end subroutine

  subroutine bar (array, len)
    character, intent(in) :: array(*)
    integer, intent(in) :: len
    print *, array(:len)
  end subroutine
  
end program
