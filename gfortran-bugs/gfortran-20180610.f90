!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86100
!!
!! SPURIOUS RUNTIME ERROR WITH -fcheck=bounds AND CLASS(*) ARRAY COMPONENTS
!!
!! Executes correctly without -fcheck=bounds. Also executes correctly if
!! the array component is rank 1, or if it is INTEGER instead of CLASS(*).
!! So seems confined to rank-2 (or greater?) allocatable CLASS(*) components.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.1.1 20180531
!!
!! $ gfortran -g -fcheck=bounds gfortran-20180610.f90
!! $ ./a.out
!! At line 16 of file gfortran-20180610.f90
!! Fortran runtime error: Array bound mismatch for dimension 1 of array '<<unknown>>' (2/1)
!! 
!! Error termination. Backtrace:
!! #0  0x4014d1 in MAIN__
!! 	at .../gfortran-20180610.f90:26
!! #1  0x401c87 in main
!! 	at .../gfortran-20180610.f90:34

type any_matrix
  class(*), allocatable :: m(:,:)
end type
type(any_matrix) :: a, b
allocate(a%m, source=reshape([3,5],shape=[1,2]))
b = a ! SPURIOUS RUNTIME ERROR with -fcheck=bounds

select type (m => b%m)  ! CHECK THE COPY
type is (integer)
  if (any(m /= reshape([3,5],shape=[1,2]))) stop 1
class default
  stop 2
end select
end
