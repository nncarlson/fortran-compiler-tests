!! https://github.com/flang-compiler/flang/issues/244
!!
!! $ less flang-bug-20170924c.f90
!! $ flang flang-bug-20170924c.f90
!! $ ./a.out
!!   T  (expect T)
!!             0  (expect 42)

type foo
  class(*), allocatable :: val
end type
type(foo) :: x, y
allocate(x%val, source=42)
y = x
print '(l1,a)', allocated(y%val), ' (expect T)'
if (allocated(y%val)) then
  select type (val => y%val)
  type is (integer)
    print '(i0,a)', val, ' (expect 42)'
  class default
    print '(a)', 'not expected type'
  end select
end if
end
