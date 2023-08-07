!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82996
!! Fixed in 12.2.0 and possibly earlier
!!
!! The issue seems to be the elemental final procedure being applied to
!! to the B array component of the BAR object
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
!! 
!! $ gfortran -g gfortran-bug-20171114a.f90 
!! $ ./a.out
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7f52f8890df7 in ???
!! #1  0x7f52f889002d in ???
!! #2  0x7f52f7d8494f in ???
!! #3  0x400fa7 in __mod_MOD_foo_destroy
!! 	at /home/nnc/Fortran/Bugs/gfortran/tmp/gfortran-bug-20171114a.f90:46
!! #4  0x400f0f in __mod_MOD___final_mod_Foo
!! 	at /home/nnc/Fortran/Bugs/gfortran/tmp/gfortran-bug-20171114a.f90:49
!! #5  0x400b29 in __mod_MOD___final_mod_Bar
!! 	at /home/nnc/Fortran/Bugs/gfortran/tmp/gfortran-bug-20171114a.f90:49
!! #6  0x401026 in sub
!! 	at /home/nnc/Fortran/Bugs/gfortran/tmp/gfortran-bug-20171114a.f90:59
!! #7  0x40104a in MAIN__
!! 	at /home/nnc/Fortran/Bugs/gfortran/tmp/gfortran-bug-20171114a.f90:55
!! #8  0x401080 in main
!! 	at /home/nnc/Fortran/Bugs/gfortran/tmp/gfortran-bug-20171114a.f90:53
!! Segmentation fault (core dumped)

module mod

  type foo
    integer, pointer :: f(:) => null()
  contains
    final :: foo_destroy
  end type
  
  type bar
    type(foo) :: b(2)
  end type

contains

  elemental subroutine foo_destroy(this)
    type(foo), intent(inout) :: this
    if (associated(this%f)) deallocate(this%f)
  end subroutine

end module

program main

  use mod
  type(bar) :: x
  call sub(x)
  
contains

  subroutine sub(x)
    type(bar), intent(out) :: x
  end subroutine

end program
