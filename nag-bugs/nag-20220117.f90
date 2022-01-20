!! SR108297: fixed in 7.1 build 7103
!!
!! INVALID INTERMEDIATE C CODE
!!
!! The NAG 7.1 compiler generates invalid intermediate C code for
!! the intrinsic CO_BROADCAST subroutine below.
!!
!! $ nagfor -coarray -f2018 nag-20220117.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7102
!! nag-20220117.f90: In function 'MAIN':
!! nag-20220117.f90:15:142: error: '__NAGf90_CoDope2' has no member named 'dim'
!!     4 | call co_broadcast(bsize, 1)

integer, allocatable :: bsize(:)[:]
allocate(bsize(5)[*])
if (this_image() == 1) bsize(:)[1] = 1
call co_broadcast(bsize, 1)
end
