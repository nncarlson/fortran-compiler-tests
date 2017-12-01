!Issue number DPD200362104
!!
!! OPTIMIZER BUG
!!
!! The following example generates the wrong results when compiled with the -O
!! flag, but correct results with -g instead of -O.  The error seems to be
!! associated with an intrinsic COUNT reference (with DIM argument) used as an
!! actual argument.  This error is new to version 15 -- it is not present in
!! versions 13 or 14.  The OS is Fedora 20 and CPU an Intel i7-4930MX.
!!
!! % ifort --version
!! ifort (IFORT) 15.0.0 20140723
!!
!! % ifort -g intel-bug-20141014-file2.f90 intel-bug-20141014-file1.f90
!! % ./a.out
!! M=2 (expect M=2)   <=== THIS IS OKAY
!!
!! % ifort -O intel-bug-20141014-file2.f90 intel-bug-20141014-file1.f90
!! % ./a.out
!! M=0 (expect M=2)   <=== THIS IS WRONG
!!

program main
  use my_mod
  real(real64) :: vf(2,25)
  vf = 1.0_real64
  call use_count_with_dim (vf)
end program

! THIS MUST GO INTO A SEPARATE SOURCE FILE
!module my_mod
!  use,intrinsic :: iso_fortran_env, only: real64
!  type some_type
!    integer :: foo
!  end type
!contains
!  subroutine use_count_with_dim (vf)
!    real(real64), intent(in) :: vf(:,:)
!    type(some_type), allocatable :: unused(:)
!    m = maxval(count(vf /= 0.0_real64, dim=1))
!    print '(a,i0,a)', 'M=', m, ' (expect M=2)'
!  end subroutine
!end module
