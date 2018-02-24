!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83118
!!
!! [REGRESSION] Intrinsic assignment of derived type with class(*) array
!! component is not done correctly when the dynamic type is character.
!!
!! This variation of gfortran-20171122.f90 replaces the initial sourced
!! allocation with a direct assignment. This generates a segfault with
!! the 8.0 trunk and 7.0 trunk.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.1 20180224 (experimental)
!! 
!! $ gfortran -g -fbacktrace gfortran-20171122b.f90 
!! $ ./a.out
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7ff54eb3294f in ???
!! #1  0x0 in ???
!! Segmentation fault (core dumped)

type :: any_vector
  class(*), allocatable :: v(:)
end type
type(any_vector) :: x, y
!allocate(x%v,source=['foo','bar'])
x%v = ['foo','bar']
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
