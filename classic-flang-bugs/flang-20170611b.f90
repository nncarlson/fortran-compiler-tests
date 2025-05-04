! https://github.com/flang-compiler/flang/issues/96
! Fixed as of 9/22/2017

module example
  type any_vector
    class(*), allocatable :: val(:)
  contains
    procedure :: get
  end type
contains
  subroutine get(this, val)
    class(any_vector), intent(in) :: this
    character(:), allocatable, intent(out) :: val(:)
    select type (this_val => this%val)
    type is (character(*))
      val = this_val
    end select
  end subroutine
end module

