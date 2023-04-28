!! SR109734: Fixed in 7125
!!
!! INVALID INTERMEDIATE C CODE
!!
!! This example produces invalid intermediate C code for the allocation
!! of a PDT array pointer when compiled with -nan.
!!
!! $ nagfor -O0 -nan nag-20230426.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7124
!! [NAG Fortran Compiler normal termination, 1 warning]
!! nag-20230426.f90: In function 'MAINIP_foo':
!! nag-20230426.f90:26:12: error: incompatible types when assigning to type
!! '__NAGf90_Dope1' from type '__NAGf90_PDTDope1'
!!     9 |   allocate(pdt(3)::u(5))
!!       |            ^
!! 

type pdt(n)
  integer,len :: n
  real :: x(n)
end type
type(pdt(:)), pointer :: a(:)
call foo(a)
contains
subroutine foo(u)
  type(pdt(:)), pointer :: u(:)
  allocate(pdt(3)::u(5))
end subroutine
end
