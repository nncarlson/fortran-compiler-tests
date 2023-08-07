!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100815; fixed in 12.2 (and perhaps earlier)
!!
!! SEGFAULT IN ASSIGNMENT TO SCALAR ALLOCATABLE POLYMORPHIC LHS
!!
!! This is a regression that was introduced in version 11
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 11.1.1 20210527
!! 
!! $ gfortran -g -O0 gfortran-20210527.f90 
!! $ ./a.out
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7f77e9546a6f in ???
!! #1  0x401405 in MAIN__
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20210527.f90:41
!! #2  0x401741 in main
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20210527.f90:43
!! Segmentation fault (core dumped)
!!

type, abstract :: func
end type

type, extends(func) :: const_func
  real :: c = 0.0
end type

type :: func_box
  class(func), allocatable :: f
end type

type :: foo
  type(func_box), allocatable :: farray(:)
end type

type(const_func) :: f
type(foo) :: this

allocate(this%farray(2))
this%farray(size(this%farray))%f = f

end
