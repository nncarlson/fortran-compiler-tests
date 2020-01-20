!! SR104737: Fixed in 6252 (6.2) and 7008 (7.0)
!!
!! WRONG CODE UNDER OPTIMIZATION
!!
!! The 6.2 compiler generates wrong code for the following example
!! when compiled with -O. The array ARR2 should ultimately have the
!! same size as ARR1, but instead has size 0.
!!
!! Credit to David Neill-Asanza (dhna@lanl.gov) for this reproducer.
!!
!! $ nagfor -O nag-20200110.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6243
!! 
!! $ ./a.out
!! STOP: 1

integer :: i, arr1(32)
integer, allocatable :: arr2(:)
arr1 = [(i, i=1,size(arr1))]
arr2 = arr1
arr2 = arr2 * 2
if (size(arr2) /= size(arr1)) stop 1
if (any(arr2 /= 2*arr1)) stop 2
end

