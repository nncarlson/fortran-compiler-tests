!! DEFERRED LENGTH PARAMETER NOT COPIED IN POINTER RANK REMAPPING
!!
!! In the following example, the pointer assignment involving rank remapping
!! does not properly define the deferred length parameter of the pointer object
!! (see F2008 5.3.14 #3). Key to the error is that the target is a
!! deferred-length allocatable
!!
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem 
!! $ pgfortran pgi-ptr-rank-remap-1.f90 
!! $ ./a.out
!! len=65538 (expect 3)
!!     1

character(:), allocatable, target :: array(:)
character(:), pointer :: ptr(:,:)
allocate(array(1), source=['foo'])
ptr(1:1,1:1) => array ! THIS IS NOT DONE CORRECTLY
print '(a,2(i0,a))', 'len=', len(ptr), ' (expect ', len(array), ')'
if (len(ptr) /= len(array)) stop 1
end
