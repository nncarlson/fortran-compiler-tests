!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125578
!!
!! SIGSEGV ON DEFAULT INITIALIZATION OF PDT WITH ALLOCATABLE COMPONENT
!!
!! The error happens without any executable statements.
!!
!! The error goes away if the unused reset procedure is deleted.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 17.0.0 20260601 (experimental)
!! 
!! $ gfortran -g -O0 gfortran-20260602b.f90 
!! $ ./a.out
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7f1b78c2728f in ???
!! #1  0x4009ce in pdt_default_initialization
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20260602b.f90:19
!! #2  0x400c97 in main
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20260602b.f90:19
!! Segmentation fault         (core dumped) ./a.out

program pdt_default_initialization

  type :: owner(k)
    integer, kind :: k = kind(0)
    integer, allocatable :: a(:)
  end type

  type(owner(kind(0))) :: x

  allocate(x%a(5))
  call reset(x)
  if (allocated(x%a)) stop 1

contains

  subroutine reset(this)
    class(owner(kind(0))), intent(inout) :: this
  end subroutine

end program
