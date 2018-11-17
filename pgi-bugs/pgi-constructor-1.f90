!! VALID STRUCTURE CONSTRUCTOR REJECTED
!!
!! Fixed in 18.10
!!
!! Structure constructor with allocatable component
!!
!! $ pgfortran pgi-constructor-1.f90 
!! PGF90-F-0155-No default initialization in structure constructor- member val$td (pgi-constructor-1.f90: 11)
!! PGF90/x86-64 Linux 18.4-0: compilation aborted

type foo
  class(*), allocatable :: val
end type
type(foo) :: x
x = foo(42)
end
