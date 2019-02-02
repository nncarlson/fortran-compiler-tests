!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84539
!!
!! Fixed on the 9.0 trunk, but persists on 8.
!!
!! SEGFAULT ON ASSIGNMENT TO CLASS(*) ALLOCATABLE ARRAY
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.1 20180224 (experimental)
!! $ gfortran -g -fbacktrace gfortran-20180223b.f90 
!! $ ./a.out
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7f908609b94f in ???
!! #1  0x400853 in MAIN__
!! 	at gfortran-20180223b.f90:21
!! #2  0x4009fd in main
!! 	at gfortran-20180223b.f90:26
!! Segmentation fault (core dumped)

class(*), allocatable :: x(:)
x = ['foo','bar'] ! SEGFAULT HERE
select type (x)
type is (character(*))
  if (any(x /= ['foo','bar'])) stop 1
end select
end
