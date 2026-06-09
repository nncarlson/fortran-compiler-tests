!!
!! REJECTS VALID CODE
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 17.0.0 20260517 (experimental)
!!
!! $ gfortran gfortran-20260601.f90
!! gfortran-20260601.f90:21:20:
!!
!!    21 |   integer(ik) :: p = 0      ! VALID BUT REJECTED
!!       |                    1
!! Error: Cannot convert INTEGER(4) to INTEGER(0) at (1)

type :: foo(ik)
  integer, kind :: ik
  integer(ik) :: p = 0      ! VALID BUT REJECTED
end type
end
