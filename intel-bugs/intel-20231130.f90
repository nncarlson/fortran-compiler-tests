!! INCORRECT RESULT FROM MINLOC/MAXLOC FOR CORNER CASES
!!
!! $ ifx --version
!! ifx (IFX) 2024.0.0 20231017
!!
!! $ ifx intel-20231130.f90 
!!
!! $ ./a.out
!!  failed           6 tests

real :: a(0), b(2,0), c(3)
logical :: mask(3)
integer :: nfail

nfail = 0

! min/maxloc should return 0 for 0-sized arrays
if (maxloc(a,dim=1) /= 0) nfail = nfail + 1
if (minloc(a,dim=1) /= 0) nfail = nfail + 1

if (any(minloc(b) /= [0,0])) nfail = nfail + 1
if (any(maxloc(b) /= [0,0])) nfail = nfail + 1

! min/maxloc should return 0 when all mask values are false
c = [1.0, 2.0, 3.0]
mask = .false.
if (maxloc(c,dim=1,mask=mask) /= 0) nfail = nfail + 1
if (minloc(c,dim=1,mask=mask) /= 0) nfail = nfail + 1

if (nfail > 0) then
  print *, 'failed', nfail, 'tests'
else
  print *, 'passed all tests'
end if

end
