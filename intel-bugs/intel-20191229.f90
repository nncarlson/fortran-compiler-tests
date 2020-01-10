!! Service Request Number: 04488021
!!
!! ALLOCATES LHS ARRAY WITH WRONG BOUNDS
!!
!! This is totally f*cked up. LHS allocatable array Z is not allocated
!! with the bounds of Y, but with the bounds of the actual argument X.
!! Affects 18.0.5 and 19.0.5
!!
!! $ ifort --version
!! ifort (IFORT) 19.0.5.281 20190815
!! $ ifort intel-20191229.f90
!! $ ./a.out
!! 2
!!

real, allocatable :: x(:)
allocate(x(-2:0))
call foo(x)
contains
  subroutine foo(y)
    real, intent(in) :: y(:)
    real, allocatable :: z(:)
    if (lbound(y,1) /= 1) stop 1
    z = y ! <== Z IS NOT ALLOCATED WITH THE CORRECT BOUNDS!
    if (lbound(z,1) /= lbound(y,1)) stop 2  ! <== EXITS HERE
  end subroutine
end
