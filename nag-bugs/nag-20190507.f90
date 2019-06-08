!! SR103454: fixed in 6.2 build 6230
!!
!! WRONG RESULT FROM SOURCED ALLOCATION
!!
!! This is a pared down version of nag-20190506.f90. Note it also uses
!! an integer value instead of a character, which highlights this problem
!! is not specific to characters.
!!
!! The following example yields the incorrect result and exits abnormally
!! at the 'STOP 1' statement. This is with NAG 6.2 (6228) and 6.1 (6149)
!!

type foo
  class(*), allocatable :: x
end type
type(foo) :: a, b

allocate(b%x, source=foo(42))         ! THIS DOES NOT DEFINE B%X CORRECTLY
!call set(b, 42)                      ! THIS DOES NOT DEFINE B%X CORRECTLY
!a = foo(42); allocate(b%x, source=a) ! THIS WORKS
!b = foo(foo(42))                     ! THIS WORKS

! Is b%x%x == 42?
select type (bx => b%x)
type is (foo)
  select type (bxx => bx%x)
  type is (integer)
    if (bxx /= 42) stop 1
  class default
    stop 2
  end select
class default
  stop 3
end select

contains

  subroutine set(f, c)
    type(foo), intent(out) :: f
    class(*), intent(in) :: c
    allocate(f%x, source=foo(c))
  end subroutine

end
