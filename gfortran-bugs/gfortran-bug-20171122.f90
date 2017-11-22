!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83118
!!
!! [REGRESSION] Intrinsic assignment of derived type with class(*) array
!! component is not done correctly when the dynamic type is character.
!!
!! Version 6.4.1 gives the expected result:
!!
!!   $ gfortran --version
!!   GNU Fortran (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
!!
!!   $ gfortran gfortran-bug-20171122.f90
!!   $ ./a.out
!!   orig=["foo","bar"]
!!   copy=["foo","bar"]
!!
!! But 8.0.0 gives an incorrect result:
!!
!!   $ gcc --version
!!   gcc (GCC) 8.0.0 20171122 (experimental)
!!
!!   $ gfortran gfortran-bug-20171122.f90
!!   $ ./a.out
!!   orig=["foo","bar"]
!!   copy=["foo","b"]
!!

type :: any_vector
  class(*), allocatable :: v(:)
end type
type(any_vector) :: x, y
allocate(x%v,source=['foo','bar'])
select type (v => x%v)
type is (character(*))
  print '("orig=[""",a,''","'',a,''"]'')', v ! expect orig=["foo","bar"]
end select
y = x ! THIS ASSIGNMENT IS NOT BEING DONE CORRECTLY
select type (v => y%v)
type is (character(*))
  print '("copy=[""",a,''","'',a,''"]'')', v ! expect copy=["foo","bar"]
end select
end
