!! Fixed in 6.2 build 6207.  6.1 status?
!!
!! This is an odd one. The NAG 6.2 and 6.1 compilers give a spurious
!! compilation error for the following example.  But the code compiles
!! without error if the style of the declaration of the function results
!! Y is changed from "dimension(:) :: y" to ":: y(:)", and
!! "dimension(m,n) :: y" to ":: y(m,n)"
!!
!! $ nagfor -c nag-20180203b.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Questionable: nag-20180203b.f90, line 36: Variable A set but never referenced
!! Warning: nag-20180203b.f90, line 36: Result Y of function PAM1 has not been assigned a value
!! Error: nag-20180203b.f90, line 23: In procedure pointer assignment, MAP is a rank 0 array function but MAP1 has rank 1
!! Error: nag-20180203b.f90, line 24: In procedure pointer assignment, PAM is a rank 0 array function but PAM1 has rank 2

module example

  procedure(map1), pointer :: map
  procedure(pam1), pointer :: pam

contains

  subroutine init
    map => map1
    pam => pam1
  end subroutine

  function map1(x) result(y)
    real, intent(in) :: x(:)
    real, allocatable, dimension(:) :: y  ! COMPILER ERROR WITH THIS ...
    !real, allocatable :: y(:)            ! BUT NO ERROR WITH THIS INSTEAD
    y = 2*x
  end function

  function pam1(m,n) result(y)
    integer, intent(in) :: m, n
    real, dimension(m,n) :: y  ! COMPILER ERROR WITH THIS ...
    !real :: y(m,n)            ! BUT NO ERROR WITH THIS INSTEAD
    y = 1.0
  end function
  
end module
