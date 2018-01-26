! https://github.com/flang-compiler/flang/issues/237
! 1/20/2018: ICE fixed, but see flang-20180120.f90

module example
contains
  integer function foo() bind(c,name='')
  end function
end module
