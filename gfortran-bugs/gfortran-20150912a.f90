!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67560
!! marked a duplicate of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67505
!! itself subsequently a duplicate of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80361
!! Fixed in 12.2.0 and probably much earlier.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 5.2.0
!! 
!! $ gfortran -fcheck=recursion gfortran-bug-20150912A.f90 
!! $ ./a.out
!! At line 20 of file gfortran-bug-20150912A.f90
!! Fortran runtime error: Recursive call to nonrecursive procedure '__final_foo_List'

module foo
  type :: list
    type(list), pointer :: next => null()
  contains
    final :: list_delete
  end type
contains
  recursive subroutine list_delete (this)
    type(list), intent(inout) :: this
    if (associated(this%next)) deallocate(this%next)
  end subroutine
end module foo

program main
  use foo
  type(list), pointer :: x
  allocate(x)
  allocate(x%next)
  deallocate(x)
end program
