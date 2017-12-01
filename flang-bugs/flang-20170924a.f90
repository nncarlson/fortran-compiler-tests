! https://github.com/flang-compiler/flang/issues/241

module example

  type :: foo
  contains
    procedure :: next => foo_next
  end type

  type :: bar
    type(bar), pointer :: next => null()
  end type

contains

  subroutine foo_next(this)
    class(foo) :: this
  end subroutine

  subroutine fubar
    type(foo) :: obj
    call obj%next
  end subroutine

end module
