!! Support request 03212814: Fixed in 19.0.4
!!
!! Array bounds are not being set correctly in ALLOCATE with MOLD=
!!
!! Fortran 2008 standard, 6.7.1.2 item 6: "When an ALLOCATE statement is
!! executed for an array with no allocate-shape-spec-list, the bounds of
!! source-expr determine the bounds of the array."
!!
!! $ ifort --version
!! ifort (IFORT) 18.0.1 20171018
!!
!! $ ifort intel-20180117.f90
!! $ ./a.out
!! 1 5
!!
!! The correct expected result is
!! 5 9
!!

integer, pointer :: a(:), b(:)
allocate(a(5:9))
allocate(b, mold=a)
print '(i0,1x,i0)', lbound(b), ubound(b)  ! EXPECT 5 9
end
