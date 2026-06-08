!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125391
!!
!! INTERNAL COMPILER ERROR
!!
!! gfortran-20260523.f90:36:32:
!!
!!    36 |     ions_out%atom = ions_in%atom
!!       |                                ^
!! internal compiler error: in gimplify_var_or_parm_decl, at gimplify.cc:3426

module gfortran_ice_reproducer_m
  implicit none

  type :: atom_t
    integer :: i = 0
  contains
    final :: atom_finalize
  end type atom_t

  type :: ions_t
    type(atom_t), allocatable :: atom(:)
  end type ions_t

contains

  impure elemental subroutine atom_finalize(this)
    type(atom_t), intent(inout) :: this
    this%i = 0
  end subroutine atom_finalize

  subroutine ions_copy(ions_out, ions_in)
    class(ions_t), intent(out) :: ions_out
    class(ions_t), intent(in) :: ions_in

    allocate(ions_out%atom(size(ions_in%atom)))
    ions_out%atom = ions_in%atom
  end subroutine ions_copy

end module gfortran_ice_reproducer_m
