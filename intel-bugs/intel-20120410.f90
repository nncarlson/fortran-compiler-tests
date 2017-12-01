!!
!! SYNOPSIS: Internal compiler error
!!
!! The following example causes an ICE with the Intel 12.1.2 compiler.
!! The code defines a generic interface for the intrinsic IBSET function
!! that operates on objects of the BITFIELD derived type.  This new
!! interface isn't actually used, however.  The call to IBSET is passed
!! a normal integer value.
!!
!! % ifort --version
!! ifort (IFORT) 12.1.2 20111128
!!
!! % ifort intel-bug-20120410.f90
!! intel-bug-20120410.f90(32): catastrophic error: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! compilation aborted for intel-bug-20120410.f90 (code 1)
!!

module bitfield_type
  type :: bitfield
    integer :: chunk
  end type bitfield
  interface ibset
    module procedure ibset_bitfield
  end interface
contains
  elemental function ibset_bitfield (bf, pos) result (bf_out)
    type(bitfield), intent(in) :: bf
    integer, intent(in) :: pos
    type(bitfield) :: bf_out
    bf_out = bf
  end function ibset_bitfield
end module bitfield_type

program main
  use bitfield_type
  type :: typeA
    integer :: integer_value
  end type
  type(typeA) :: objA
  objA%integer_value = ibset(objA%integer_value, pos=0)
end program
