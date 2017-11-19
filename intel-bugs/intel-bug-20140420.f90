!!
!! INTERNAL COMPILER ERROR
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort -c -standard-semantics foo.f90
!! 010101_13220
!! 
!! catastrophic error: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! 

subroutine fubar (array, mask)
integer, allocatable :: array(:)
logical :: mask(:)
array = merge(1, array, mask)
end subroutine
