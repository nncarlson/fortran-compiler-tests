!!
!! SPURIOUS RUNTIME ERROR
!!
!! $ ifx --version
!! ifx (IFX) 2024.0.0 20231017
!!
!! $ ifx -traceback intel-20231205.f90 
!!
!! $ ./a.out
!!  before foo assignment
!!  before foo_bar assignment
!! forrtl: severe (122): invalid attempt to assign into a pointer that is not associated
!! Image              PC                Routine            Line        Source             
!! a.out              0000000000408E7F  Unknown               Unknown  Unknown
!! a.out              0000000000405327  foo_bar_copy               63  intel-20231205.f90
!! a.out              0000000000405679  _unnamed_main$$            83  intel-20231205.f90
!! a.out              000000000040519D  Unknown               Unknown  Unknown
!! libc.so.6          00007F81CC64A550  Unknown               Unknown  Unknown
!! libc.so.6          00007F81CC64A609  __libc_start_main     Unknown  Unknown
!! a.out              00000000004050B5  Unknown               Unknown  Unknown
!!
!! Expected output is:
!!
!!  before foo assignment
!!  before foo_bar assignment
!!  after foo_bar assignment
!!  after foo assignment
!!

module foo_class

  type, abstract :: foo
  contains
    procedure, private :: foo_copy
    generic :: assignment(=) => foo_copy
    procedure(foo_copy), deferred :: foo_copy_
  end type

  type, extends(foo) :: foo_bar
    class(*), allocatable :: value
  contains
    procedure :: foo_copy_ => foo_bar_copy
  end type

contains

  subroutine foo_copy(lhs, rhs)
    class(foo), intent(inout) :: lhs
    class(foo), intent(in) :: rhs
    if (same_type_as(lhs, rhs)) then
      call lhs%foo_copy_(rhs)
    else
      error stop
    end if
  end subroutine

  subroutine foo_bar_copy(lhs, rhs)
    class(foo_bar), intent(inout) :: lhs
    class(foo), intent(in) :: rhs
    select type (rhs)
    type is (foo_bar)
      print *, 'before foo_bar assignment'
      lhs%value = rhs%value ! RUNTIME ERROR HERE
      print *, 'after foo_bar assignment'
    end select
  end subroutine

end module

use foo_class
class(foo), allocatable :: src, dest

!! Define SRC
allocate(foo_bar::src)
select type (src)
type is (foo_bar)
  allocate(src%value, source=1)
end select

!! Copy SRC to DEST
allocate(dest, mold=src)
print *, 'before foo assignment'
dest = src
print *, 'after foo assignment'

end
