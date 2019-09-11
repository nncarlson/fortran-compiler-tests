!! SR104042: Fixed in 6.2 build 6239
!!
!! WRONG RESULT FROM NORM2 WITH REAL64 ARRAY SECTION ARGUMENT
!!
!! This is an alteration of nag-20190831.f90 which still fails after the
!! fix in build 6238 for the latter test case.
!!
!! The following example norm2 should return sqrt(91) but instead returns
!! sqrt(30) for a real64 array, but the correct result for real32.
!!
!! $ nagfor nag-20190906.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6238
!! [NAG Fortran Compiler normal termination]
!! $ ./a.out
!! STOP: 1
!!

double precision x(0:3,0:4)
x = 0
x(1:2,1:3) = reshape([1,2,3,4,5,6], shape=[2,3])
if (norm2(x(1:2,1:3)) /= sqrt(91.0d0)) stop 1  ! WRONG NORM2 RESULT
end
