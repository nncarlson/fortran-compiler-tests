!!
!! PARENT COMPONENT NAME NOT THE RENAMED PARENT TYPE
!!
!! The NAG compiler gives this error for the following example:
!!
!! $ nagfor nag-20180203c.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Error: nag-bug-20180203c.f90, line 12: POINT is not a component of P
!!        detected at %@POINT
!!
!! I don't think this is correct. The name of the parent component is POINT
!! and not PUNKT. From the F08 standard:
!!
!! Note 4.51: "The name of the parent type might be a local name introduced
!! via renaming in a USE statement."  Here that is POINT.
!!
!! 4.5.7.2: "An extended type has a scalar, nonpointer, nonallocatable, parent
!! component with [...] The name of this component is the parent type name.
!!

module punkt_type
  type punkt
    real x, y
  end type
end module

use punkt_type, only: point => punkt
type, extends(point) :: color_point ! Note 4.51 (F08) POINT is the name of the parent type
  integer color
end type
type(color_point) :: p
p%point%x = 1.0   ! THE PARENT COMPONENT SHOULD BE P%POINT, NOT P%PUNKT
end
