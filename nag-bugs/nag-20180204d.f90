!! Fixed in 6.2 build 6216.
!!
!! INTERNAL COMPILER ERROR -- UNFORMATTED SEQUENCE DT INPUT
!!
!! This example triggers an internal compiler error with the NAG 6.2 compiler.
!!
!! $ nagfor -w=uda nag-20180204d.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Panic: nag-20180204d.f90: Unexpected expr node type 290
!! Internal Error -- please report this bug

module foo_type

  type :: foo
    sequence
    integer :: a, b
  end type

  interface read(unformatted)
    module procedure foo_ufr
  end interface

  interface write(unformatted)
    module procedure foo_ufw
  end interface

contains
  
  subroutine foo_ufr(dtv, unit, iostat, iomsg)
    type(foo), intent(inout) :: dtv
    integer, intent(in) :: unit
    integer, intent(out) :: iostat
    character(*), intent(inout) :: iomsg
    read(unit) dtv%a, dtv%b
  end subroutine
  
  subroutine foo_ufw(dtv, unit, iostat, iomsg)
    type(foo), intent(in) :: dtv
    integer, intent(in) :: unit
    integer, intent(out) :: iostat
    character(*), intent(inout) :: iomsg
    write(unit) dtv%a, dtv%b
  end subroutine

end module

use foo_type
integer :: lun
type(foo) :: var = foo(1,2)
open(newunit=lun,status='scratch',form='unformatted')
write(lun) var
rewind(lun)
read(lun) var ! THIS LINE TRIGGERS THE ICE
end
