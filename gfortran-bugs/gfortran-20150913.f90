!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67564
!! Fixed in 12.2.0 and probably much earlier.
!!
!! The following example segfaults on the allocate statement
!!
!! $ gfortran --version gfortran-bug-20150913.f90 
!! GNU Fortran (GCC) 6.0.0 20150906 (experimental)
!! 
!! $ gfortran gfortran-bug-20150913.f90 
!! $ ./a.out
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7F338430C517
!! #1  0x7F338430CB5E
!! #2  0x7F338380D95F
!! #3  0x7F33838677ED
!! #4  0x400932 in __copy_character_1.3388 at gfortran-bug-20150913A.f90:?
!! #5  0x400AC6 in MAIN__ at gfortran-bug-20150913A.f90:?
!! Segmentation fault (core dumped)

program main
  type :: any_vector
    class(*), allocatable :: x(:)
  end type
  type(any_vector) :: a
  allocate(a%x(2), source=['foo','bar'])
  select type (foo => a%x)
  type is (character(*))
    print '(a,i0,a)', 'len=', len(foo), ' (expect 3)'
    print '(4a)', 'foo=', foo, ' (expect foobar)'
  end select
end program
