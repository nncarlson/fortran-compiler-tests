!!
!! INTERNAL COMPILER ERROR
!!
!! The following example triggers an ICE with nagfor version 7.1.29
!!
!! $ nagfor -coarray -num_images=2 bug.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7129
!! Panic: bug.f90: mkarraydesc unexpected node type 562
!! Internal Error -- please report this bug
!!
!! This works fine if A has rank 0 or 1 instead of 2
!!

real :: a(2,2)[*]
a = 1.0
sync all
if (this_image() < num_images()) print *, a(:,:)[this_image()+1]
end
