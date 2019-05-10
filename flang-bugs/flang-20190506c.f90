!! https://github.com/flang-compiler/flang/issues/715
!!
!! INTERNAL COMPILER ERROR
!!
!! The March 2019 binary release gives this ICE on the following example:
!!
!! $ flang flang-20190506b.f90 
!! F90-F-0000-Internal compiler error. gen_llvm_expr(): no incoming ili       0  (flang-20190506b.f90: 6)
!!

type foo
  class(*), allocatable :: x
end type
type(foo) :: a
a = foo('bizbat')
end
