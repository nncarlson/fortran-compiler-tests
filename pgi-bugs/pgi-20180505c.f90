!! INTERNAL COMPILER ERROR
!!
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem 
!! $ pgfortran -c pgi-20180505c.f90 
!! PGF90-S-0000-Internal compiler error. size_of: attempt to get size of assumed size character       0  (pgi-20180505c.f90: 4)
!!   0 inform,   0 warnings,   1 severes, 0 fatal for sub

subroutine sub(array)
  character(*), intent(in) :: array(:)
  class(*), allocatable :: copy(:)
  allocate(copy, source=array)
end
