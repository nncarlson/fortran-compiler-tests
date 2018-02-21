!! SR99921
!!
!! SPURIOUS COMPILE ERROR WITH PDT AND EXTENSION
!!
!! The NAG 6.2 compiler gives this compile error for the following example
!!
!! $ nagfor nag-20180204c.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Fatal Error: nag-20180204c.f90: Extension FOO of length type parameter dependent type BAR adds component N
!!
!! I believe this is spurious error.  The Intel and gfortran compilers
!! accept the code.  In addition, if the declaration of the DIM variable
!! used in the ALLOCATE statement is moved as indicated below (a completely
!! innocuous change) the error goes away.  I also don't understand the
!! error message; "extension BAR of [...] type FOO" would make more sense.

module vars
  integer :: dim = 4
end module

use vars           ! ERROR IF DIM GOTTEN THROUGH USE
!integer :: dim=4  ! NO ERROR IF DIM IS A LOCAL VARIABLE 

type :: foo(dim)
  integer,len  :: dim
  real :: array(dim)
end type

type, extends(foo) :: bar
  integer :: n
end type

class(foo(:)), allocatable :: var
allocate(bar(dim) :: var)

end
