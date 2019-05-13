!! https://github.com/flang-compiler/flang/issues/722
!!
!! WRONG TYPE FROM POLYMORPHIC SOURCED ALLOCATION WITH MOLD=
!!
!! The following example does a sourced allocation with MOLD= involving
!! CLASS(*) variables. The variable is allocated but its dynamic type is not
!! being defined correctly as required, and execution exits early at the
!! STOP 4 statement. This is with the March 2019 binary release.
!!

class(*), allocatable :: x, y

allocate(y, source=42)  ! THIS WORKS CORRECTLY
select type (y)
type is (integer)
  if (y /= 42) stop 1
class default
  stop 2
 end select

allocate(x, mold=y)     ! DYNAMIC TYPE OF X NOT DEFINED CORRECTLY
if (.not.allocated(x)) stop 3
select type (x)
type is (integer)
class default
  stop 4                ! <== EXITS HERE
end select
    
end
