!! https://github.com/flang-compiler/flang/issues/243
!!
!! $ flang -c flang-bug-20170924b.f90
!! F90-F-0155-Too many elements in structure constructor- type foo (flang-bug-20170924b.f90: 5)
!! F90/x86-64 Linux Flang - 1.5 2017-05-01: compilation aborted
!!
!! Incorrect compile error fixed in 543785e (20180615).
!!
!! Example augmented to check result of the assignment. It is incorrect.
!!
!! $ flang flang-20170924b.f90
!! $ ./a.out
!!     2

type foo
  class(*), allocatable :: val
end type
type(foo) :: x
x = foo(42)
select type (val => x%val)
type is (integer)
  if (val /= 42) stop 1
class default
  stop 2
end select
end
