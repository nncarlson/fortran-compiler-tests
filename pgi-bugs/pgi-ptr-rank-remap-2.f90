!! BAD ARRAY BOUNDS WITH CLASS(*) POINTER RANK REMAPPING
!!
!! PGI seems to be completely broken when it comes to pointer
!! rank remapping for CLASS(*) objects.
!!
!! Expected output:
!! lbound=1 1, ubound=2 2, shape=2 2
!!
!! pgfortran output:
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem
!! $ pgfortran pgi-ptr-rank-remap-2.f90
!! $ ./a.out
!! lbound=1 0, ubound=4 0, shape=4 -65536
!!    1

class(*), allocatable, target :: array(:)
class(*), pointer :: p(:,:)
allocate(array, source=[1,2,3,4])
p(1:2,1:2) => array
print '(3(a,i0,1x,i0))', 'lbound=', lbound(p), ', ubound=', ubound(p), ', shape=', shape(p)
if (any(lbound(p) /= 1 .or. ubound(p) /= 2)) stop 1
end
