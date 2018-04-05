!! SR100256. Fixed in 6.2 build 6210.
!!
!! INTERNAL COMPILER ERROR -- PDT
!!
!! The following example triggers an internal error with NAG 6.2
!! but compiles without error with 6.1.
!!
!! $ nagfor nag-20180205b.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Panic: nag-20180205b.f90: NYI non-final len-varying comp
!! Internal Error -- please report this bug

type :: foo(len)
  integer,len :: len
  character(len) :: string
  integer :: array(len)
end type
type(foo(2)) :: x
end
