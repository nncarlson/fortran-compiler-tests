!! SR100256. Fixed in 6.2 build 6207; 6.1 build 6148
!!
!! INTERNAL COMPILER ERROR -- EXTENSION OF PDT ALLOCATION
!!
!! The following example triggers an internal error with NAG 6.1
!!
!! $ nagfor nag-20180205c.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Panic: nag-20180205c.f90: Missing dtp for kind?
!! Internal Error -- please report this bug

type :: foo(a,b)
  integer,kind :: a = 1
  integer,len  :: b
end type

type, extends(foo) ::  bar
  real, allocatable :: array(:)
end type

class(bar(b=:)), allocatable :: var
allocate(bar(b=4) :: var)

end
