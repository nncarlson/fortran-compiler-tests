!! https://github.com/flang-compiler/flang/issues/309
!! This example now executes correctly with 543785e7 (20180615)
!!
!! This example produces incorrect results. Likely the same problem as
!! in flang-20171122c.f90.
!!
!! $ flang flang-20171122e.f90 
!! $ ./a.out
!! orig=["fo",""]
!! copy=["fo",""]

type :: any_vector
  class(*), allocatable :: v(:)
end type
type(any_vector) :: x, y
allocate(x%v,source=['foo','bar'])
select type (v => x%v)
type is (character(*))
  print '("orig=[""",a,''","'',a,''"]'')', v ! expect orig=["foo","bar"]
end select
y = x
select type (v => y%v)
type is (character(*))
  print '("copy=[""",a,''","'',a,''"]'')', v ! expect copy=["foo","bar"]
end select
end
