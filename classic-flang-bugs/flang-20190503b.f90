!! https://github.com/flang-compiler/flang/issues/244
!!
!! This is a derived type-valued version of flang-20170924c.f90
!!
!! The following example should terminate normally, but instead
!! exits at the STOP 3 statement.
!!
!! $ flang flang-bug-20190503b.f90
!! $ ./a.out
!!   3

type point
  real a, b
end type

type foo
  class(*), allocatable :: val
end type
type(foo) :: x, y

allocate(x%val, source=point(1.0,2.0))
y = x

select type (p => x%val)
type is (point)
  if (p%a /= 1.0 .or. p%b /= 2.0) stop 1
class default
  stop 2
end select

select type (p => y%val)
type is (point)
  if (p%a /= 1.0 .or. p%b /= 2.0) stop 3
class default
  stop 4
end select

end
