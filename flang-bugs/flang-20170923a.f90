! https://github.com/flang-compiler/flang/issues/237

module example
contains
  integer function foo() bind(c,name='')
  end function
end module
