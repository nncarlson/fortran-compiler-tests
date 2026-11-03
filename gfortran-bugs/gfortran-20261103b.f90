!! Fixed in gfortran 16.1.1 (verified with 20260517).
!!
!! INTERNAL COMPILER ERROR
!!
!! Forwarding an assumed-rank dummy to a contiguous assumed-rank dummy.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 15.2.0
!! $ gfortran -c gfortran-20261103b.f90
!! internal compiler error: in gfc_trans_create_temp_array,
!! at fortran/trans-array.cc:1560
!!

subroutine sub(x)
  integer, intent(in) :: x(..)
  call check(x)
contains
  subroutine check(x)
    integer, contiguous, intent(in) :: x(..)
  end subroutine
end subroutine
