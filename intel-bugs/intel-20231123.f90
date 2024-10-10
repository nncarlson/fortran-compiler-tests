!! CMPLRLLVM-53947 -- Fixed in 2024.2 (and ifort 21.13)
!!
!! REJECTS VALID CODE
!!
!! $ ifx intel-20231123.f90 
!! intel-20231123.f90: error #5286: Ambiguous generic interface NEW_SECURE_HASH: previously declared specific procedure SECURE_HASH_FACTORY::NEW_SECURE_HASH_ALLOC is not distinguishable from this declaration. [SECURE_HASH_FACTORY::NEW_SECURE_HASH_PTR]
!! intel-20231123.f90(43): error #7496: A non-pointer actual argument shall have a TARGET attribute when associated with a pointer dummy argument.   [H1]
!! call new_secure_hash(h1)
!! ---------------------^
!! compilation aborted for intel-20231123.f90 (code 1)

module secure_hash_factory

  implicit none
  private

  public :: secure_hash, new_secure_hash

  type, abstract :: secure_hash
  end type

  interface new_secure_hash
    procedure new_secure_hash_alloc, new_secure_hash_ptr
  end interface

contains

  subroutine new_secure_hash_alloc(hash)
    class(secure_hash), allocatable, intent(out) :: hash
    write(*,'(a)',advance='no') 'a'
  end subroutine

  subroutine new_secure_hash_ptr(hash)
    class(secure_hash), pointer, intent(out) :: hash
    write(*,'(a)',advance='no') 'p'
  end subroutine

end module

use secure_hash_factory
class(secure_hash), allocatable :: h1
class(secure_hash), pointer :: h2
call new_secure_hash(h1)
call new_secure_hash(h2)
write(*,*)
end
