!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103394
!!
!! GFortran 11.2 and earlier, including the current 12.0 development
!! all generate bad object code for the foo_vector_func(...) structure
!! constructor expression below. The program should exit normally but
!! instead bails at the "stop 1" statement.
!!

module foo_type

  type :: foo
  contains
    procedure :: alloc_foo_vector_func
  end type
  
  type, abstract :: vector_func
  end type

  type, extends(vector_func) :: foo_vector_func
    type(foo), pointer :: ptr
  end type

contains

  subroutine alloc_foo_vector_func(this, vf)
    class(foo), intent(in), target :: this
    class(vector_func), allocatable, intent(out) :: vf
    allocate(vf, source=foo_vector_func(this))  ! DOESN'T WORK CORRECTLY
    !vf = foo_vector_func(this)  ! DOESN'T WORK EITHER
  end subroutine

end module

program main
  use foo_type
  type(foo), target :: x
  class(vector_func), allocatable :: vf
  call x%alloc_foo_vector_func(vf)
  select type (vf)
  type is (foo_vector_func)
    if (.not.associated(vf%ptr, x)) stop 1  ! SHOULD NOT EXIT HERE
  end select
end program
