!! SR104042
!!
!! BAD C CODE GENERATED
!!
!! $ nagfor -c nag-20190826b.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6228
!! [NAG Fortran Compiler normal termination]
!! nag-20190826b.f90: In function 'example_MP_sub':
!! nag-20190826b.f90:17:32: error: 'x_Len' undeclared (first use in this function)
!!    subroutine sub
!!                                 ^    
!! nag-20190826b.f90:17:32: note: each undeclared identifier is reported only once for each function it appears in
!!

module example

contains

  subroutine sub
  
    type :: foo(n)
      integer,len :: n
      integer :: array(0:n)
    end type
    type(foo(10)) :: x
    namelist /nml/ x

  end subroutine

end module
