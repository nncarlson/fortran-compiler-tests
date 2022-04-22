!! SR108695
!!
!! SEGFAULT WITH -C=dangling
!!
!! When the following example is compiled with -C=dangling it will
!! segfault when run, but runs without error when -C=dangling is
!! omitted. Note that there are no pointers in the example, and that
!! the problem goes away if the target attribute is removed from one
!! of the dummy arguments.
!!
!! $ nagfor -C=dangling nag-20220421.f90
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7106
!! $ ./a.out
!!  in toolpath_driver::alloc_toolpath
!! Segmentation fault (core dumped)
!!
!! This is the expected output of a successful run:
!!
!! $ nagfor nag-20220421.f90
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7106
!! $ ./a.out
!!  in toolpath_driver::alloc_toolpath
!!  in toolpath_factory::alloc_toolpath
!!

module toolpath_type
  type :: toolpath
    real, allocatable :: time(:)
  end type
end module

module toolpath_factory
  use toolpath_type
contains
  subroutine alloc_toolpath(path)
    type(toolpath), allocatable, intent(out), target :: path
    print *, 'in toolpath_factory::alloc_toolpath'
  end subroutine
end module

module toolpath_driver
  use toolpath_type
contains
  subroutine alloc_toolpath(path)
    use toolpath_factory, only: alloc_tp => alloc_toolpath
    type(toolpath), allocatable, intent(out) :: path
    print *, 'in toolpath_driver::alloc_toolpath'
    call alloc_tp(path)
  end subroutine
end module

use toolpath_driver
type(toolpath), allocatable :: tp
call alloc_toolpath(tp)
end
