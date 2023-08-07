!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=45794
!! Fixed in 12.2.0 and probably much earlier.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 4.6.0 20100924 (experimental)
!! 
!! $ gfortran -c bug3.f90 
!! bug3.f90: In function 'foo':
!! bug3.f90:17:0: internal compiler error: Segmentation fault
!!

subroutine foo (vector, mask)
  real :: vector(:)
  logical, optional :: mask(:)
  integer :: loc(1)
  if (present(mask)) then
    loc = maxloc(vector, mask)
  end if
end subroutine
