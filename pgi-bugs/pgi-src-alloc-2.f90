!! BAD CLASS(*) ALLOCATION WITH CHARACTER ARRAY SOURCE
!!
!! Fixed in 18.10
!!
!! The following example produces incorrect results with 18.4.
!! The correct results are:
!!
!! ["foo","bar"]
!!
!! But pgfortran gives this:
!!
!! $ pgfortran pgi-src-alloc-2.f90 
!! $ ./a.out
!! ["fo",""]
!!    13

class(*), allocatable :: x(:)
allocate(x, source=['foo','bar'])  ! SOMETHING GOES WRONG HERE
select type (x)
type is (character(*))
  print '(''["'',a,''","'',a,''"]'')', x ! expect ["foo","bar"]
  if (len(x) /= 3) stop 11
  if (size(x) /= 2) stop 12
  if (any(x /= ['foo','bar'])) stop 13  ! EXITS HERE
class default
  stop 10
end select
end
