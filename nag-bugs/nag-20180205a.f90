!! SR100256
!!
!! INTERNAL COMPILER ERROR -- PDT WITH PDT COMPONENT
!!
!! The following example triggers an internal error with NAG 6.2
!! but compiles without error with 6.1.
!!
!! $ nagfor nag-20180205a.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Panic: nag-20180205a.f90: LPP zero
!! Internal Error -- please report this bug

type :: foo(a)
  integer,len :: a
end type
type :: bar(b)
  integer,len :: b
  type(foo(2)) :: array(b)
end type
type(bar(1)) :: var
end
