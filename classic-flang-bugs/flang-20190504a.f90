!! https://github.com/flang-compiler/flang/issues/713
!!
!! INTERNAL COMPILER ERROR
!!
!! With March 2019 binary release:
!!
!! $ flang flang-20190504a.f90 
!! F90-S-0000-Internal compiler error. size_of: attempt to get size of assumed size character       0  (flang-20190504a.f90: 15)
!!   0 inform,   0 warnings,   1 severes, 0 fatal for MAIN
!!

character(:), allocatable :: a(:)
class(*), allocatable :: b(:)
a = ['fubar']
allocate(b(lbound(a,1):ubound(a,1)), source=a) ! <== ICE HERE
!allocate(b, source=a) ! allowed by F2008 
select type (b)
type is (character(*))
  if (len(b) /= 5) stop 1
  if (size(b) /= 1) stop 2
  if (b(1) /= 'fubar') stop 3
class default
  stop 4
end select
end
