!! SRN 03140120
!!
!! ICE on MERGE inside TYPE IS block
!!
!! ICE on 18.0.1, 17.0.1, 16.0.2. No ICE if val is an integer
!! variable and not polymorphic.
!! 
!! $ ifort --version
!! ifort (IFORT) 18.0.1 20171018
!! Copyright (C) 1985-2017 Intel Corporation.  All rights reserved.
!! 
!! $ ifort intel-20171126.f90 
!! intel-20171126.f90(5): catastrophic error: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! compilation aborted for intel-20171126.f90 (code 1)
!!

class(*), allocatable :: val
allocate(val, source=42)
select type (val)
type is (integer)
print *, merge('pass', 'fail', val==42)
end select
end
