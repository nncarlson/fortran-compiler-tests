module my_mod
  use,intrinsic :: iso_fortran_env, only: real64
  type some_type
    integer :: foo
  end type
contains
  subroutine use_count_with_dim (vf)
    real(real64), intent(in) :: vf(:,:)
    type(some_type), allocatable :: unused(:)
    m = maxval(count(vf /= 0.0_real64, dim=1))
    print '(a,i0,a)', 'M=', m, ' (expect M=2)'
  end subroutine
end module
