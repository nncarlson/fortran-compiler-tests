!!
!! INVALID INTERMEDIATE C CODE
!!
!! This example produces invalid intermediate C code when accessing the
!! length parameter of a parameterized polymorphic variable.
!!
!! $ nagfor nag-20230527.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7127
!!
!! nag-20230527.f90: In function 'mfe_disc_type_MP_init':
!! nag-20230527.f90:45:11: error: 'this_' is a pointer; did you mean to use '->'?
!!    36 |     n = this%p%npde
!!       |           ^
!!       |           ->

module pde_class
  type, abstract :: pde(npde)
    integer,len :: npde
  end type
end module

module navier_stokes_type
  use pde_class
  type, extends(pde) :: navier_stokes
  end type
contains
  subroutine alloc_navier_stokes(p)
    class(pde(:)), allocatable :: p
    allocate(navier_stokes(npde=3) :: p)
  end subroutine
end module

module mfe_disc_type
  use pde_class
  type :: foo
    class(pde(:)), allocatable :: p
  contains
    procedure :: init
  end type
contains
  subroutine init(this)
    use navier_stokes_type
    class(foo), intent(out) :: this
    integer :: n
    call alloc_navier_stokes(this%p)
    n = this%p%npde
  end subroutine
end module

program main
  use mfe_disc_type
  type(foo) :: x
  call x%init
  if (x%p%npde /= 3) error stop
end program

