!! SR109729: Fixed in 7125
!!
!! INVALID INTERMEDIATE C CODE
!!
!! This example produces invalid intermediate C code for the assignment
!! of a scalar PDT variable to an element of an allocated PDT array with
!! the same length-type parameter.
!!
!! $ nagfor -O0 nag-20230426b.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7124
!!
!! Warning: nag-20230426b.f90, line 12: Variable B referenced but never set
!! [NAG Fortran Compiler normal termination, 1 warning]
!! nag-20230426b.f90: In function 'MAIN':
!! nag-20230426b.f90:27:89: error: incompatible types when assigning to type
!! 'struct _PDT_UNKNOWNLEN_MAINDT_pdt' from type 'struct _PDT_3_MAINDT_pdt'
!!    10 | a(1) = b
!!       |                                                                                         ^ 

type pdt(n)
  integer,len :: n
  real :: x(n)
end type

type(pdt(:)), allocatable :: a(:)
type(pdt(3)) :: b

allocate(pdt(3) :: a(2))
a(1) = b

end
