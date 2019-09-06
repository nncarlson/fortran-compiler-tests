!! SR104042: Fixed for 6.2 in build 6238. Still present in 6.1.
!!
!! WRONG RESULT FROM NORM2 WITH REAL64 ARRAY SECTION ARGUMENT
!!
!! The following example gives the wrong result for a real64 array,
!! but the correct result for real32 (sqrt(2) rather than 2). Comparing
!! the generated C code for the two cases suggests that the problem must
!! be in the real64 version of the NORM2 library function.
!!
!! $ nagfor nag-20190831.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6236
!! [NAG Fortran Compiler normal termination]
!! [nnc@noether nag-bugs]$ ./a.out
!! STOP: 1
!!

double precision x(0:3,0:3)
x = 1
if (norm2(x(1:2,1:2)) /= 2) stop 1  ! WRONG NORM2 RESULT
end
