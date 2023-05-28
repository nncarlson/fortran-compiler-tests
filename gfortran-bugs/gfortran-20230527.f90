!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110012
!!
!! INTERNAL COMPILER ERROR
!!
!! (Same example as nag-bug-20230527.f90 but fails for different reason.)
!!
!! $ gfortran gfortran-20230527.f90 -c
!! f951: internal compiler error: in resolve_fl_derived, at fortran/resolve.cc:15532
!! 0x699d67 resolve_fl_derived
!! 	../../gcc/fortran/resolve.cc:15532
!! 0x79c3df resolve_symbol
!! 	../../gcc/fortran/resolve.cc:15916
!! 0x7c7c32 do_traverse_symtree
!! 	../../gcc/fortran/symbol.cc:4190
!! 0x7a77ce resolve_types
!! 	../../gcc/fortran/resolve.cc:17879
!! 0x7aeb0c gfc_resolve(gfc_namespace*)
!! 	../../gcc/fortran/resolve.cc:17994
!! 0x78dedf gfc_parse_file()
!! 	../../gcc/fortran/parse.cc:6861
!! 0x7e63bf gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.cc:229
!! Please submit a full bug report, with preprocessed source (by using -freport-bug).

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
  end type
!contains
!  subroutine init(this)
!    use navier_stokes_type
!    class(foo), intent(out) :: this
!    integer :: n
!    call allocate_navier_stokes(p)
!    n = this%p%npde
!    print *, n
!  end subroutine
end module

