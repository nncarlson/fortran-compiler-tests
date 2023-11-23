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
