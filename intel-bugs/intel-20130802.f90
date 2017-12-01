!!
!! The Intel compiler is stumbling over the type-is statement
!! in the following example when it shouldn't be.
!!
!! % ifort --version
!! ifort (IFORT) 13.1.2 20130514
!! 
!! % ifort intel-bug-20130802.f90 
!! intel-bug-20130802.f90(21): error #6402: prPromoteSym : Illegal KIND & CLASS mix   [KIND]
!!   type is (integer(kind(val)))
!! -------------------^
!! compilation aborted for intel-bug-20130802.f90 (code 1)
!!

subroutine fubar (cs, val)

  class(*) :: cs
  integer :: val
  
  select type (cs)
  type is (integer(kind(val)))
  end select
  
end subroutine
