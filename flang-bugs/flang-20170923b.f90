!! https://github.com/flang-compiler/flang/issues/239
!! Fixed as of 3/19/2018.
!!
!! $ flang -c flang-bug-20170923b.f90 
!! F90-F-0155-Empty structure constructor() - type map (flang-bug-20170923b.f90: 12)
!! F90/x86-64 Linux Flang - 1.5 2017-05-01: compilation aborted

module example

  type :: map
    integer, pointer :: first => null()
  end type

  type :: parameter_list
    type(map) :: params = map() ! this is entirely valid
  end type

end module
