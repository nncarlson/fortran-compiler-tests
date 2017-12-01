! https://github.com/flang-compiler/flang/issues/96

module example
  type any_vector
    class(*), allocatable :: val(:)
  end type
contains
  subroutine foo(this)
    class(any_vector), intent(in) :: this
    integer :: n
    select type (this_val => this%val)
    type is (character(*))
      do n = 1, size(this_val)
        print *, trim(this_val(n))
      end do
    end select
  end subroutine
end module

