!! Service Request Number: 04488016
!!
!! INTERNAL COMPILER ERROR
!!
!! Affects both 18.0.5 and 19.0.5. No error if string is not allocatable.
!!
!! $ ifort --version
!! ifort (IFORT) 19.0.5.281 20190815
!! 
!! $ ifort intel-20191228.f90 
!! intel-20191228.f90(4): catastrophic error: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! compilation aborted for intel-20191228.f90 (code 1)

character(:), allocatable :: string
string = 'fubar'
associate (substring => string(3:))
  if (substring /= 'bar') stop 1
end associate
end
