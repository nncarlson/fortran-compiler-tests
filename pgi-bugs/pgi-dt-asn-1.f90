!! BAD INTRINSIC ASSIGNMENT OF DT WITH CLASS(*) ALLOCATABLE COMPONENT
!!
!! Program should exit without output.
!!
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem 
!!
!! $ pgfortran pgi-dt-asn-1.f90 
!! $ ./a.out
!!    22

type foo
  class(*), allocatable :: val
end type
type(foo) :: x, y

allocate(x%val, source=42)
if (.not.allocated(x%val)) stop 11
select type (val => x%val)
type is (integer)
  if (val /= 42) stop 12
class default
  stop 13
end select

y = x ! THIS INTRINSIC ASSIGNMENT IS NOT EXECUTED CORRECTLY
if (.not.allocated(y%val)) stop 21
select type (val => y%val)
type is (integer)
  if (val /= 42) stop 22  ! EXITS HERE
class default
  stop 23
end select
end
