!!
!! INVALID INTERMEDIATE C CODE -- 3-ARG BESSEL_JN VERSION
!!
!! NAG Fortran 6.1 and 6.2 generates invalid C code for the following example.
!!
!! $ nagfor nag-20180203a.f90 -c
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! [NAG Fortran Compiler normal termination]
!! nag-20180203a.f90: In function 'bar_':
!! nag-20180203a.f90:4:18: error: too many arguments to function '__NAGf90_jn_f'
!!    array = bessel_jn(1,n,x)
!!                   ^~~~~~~~~    
!! In file included from /opt/nag/nagfor-6.2/lib/nagfortran.h:133:0,
!!                  from nag-20180203a.f90:1:
!! /opt/nag/nagfor-6.2/lib/libfm.h:119:19: note: declared here
!!  VPure float CDECL __NAGf90_jn_f(INT64 n,float x);

subroutine bar(n,x,array)
  integer n
  real x, array(n)
  array = bessel_jn(1,n,x)
end subroutine
