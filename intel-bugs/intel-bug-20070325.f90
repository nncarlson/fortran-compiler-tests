!!
!! SYNOPSIS: Compiler mishandles elemental defined assignment
!!
!! In the following example of standard-conforming code, the 9.1.043 (EM64T)
!! compiler incorrectly flags a whole-array assignment as involving an
!! assumed-size array.  There is no assumed-size array in this example.
!! If the ELEMENTAL attribute is dropped from the defined assignment
!! procedure, the compiler is okay with the whole-array assignment (of
!! course intrinsic assignment is performed, which isn't what's wanted).
!! My conclusion is that compiler is mishandling the elemental defined
!! assignment somehow.
!!
!! % ifort --version
!! ifort (IFORT) 9.1 20070215
!!
!! % ifort -c intel-bug-20070325.f90
!! fortcom: Error: intel-bug-20070325.f90, line 51: An assumed-size array shall not be written as a whole array reference except as an actual argument in a procedure reference for which the shape is not required.   [P]
!!     this%p = p
!! ---------^
!! compilation aborted for intel-bug-20070325.f90 (code 1)
!!

module typeA_mod
  type :: typeA
    integer, pointer :: ptr => null()
  end type
  interface assignment(=)
    module procedure copy_typeA
  end interface
contains
  elemental subroutine copy_typeA (dest, src)
    type(typeA), intent(out) :: dest
    type(typeA), intent(in)  :: src
    if (associated(src%ptr)) then
      allocate(dest%ptr)
      dest%ptr = src%ptr
    end if
  end subroutine
end module

module typeB_mod
  use typeA_mod
  type :: typeB
    type(typeA), pointer :: p(:) => null()
  end type
contains
  subroutine create_typeB (this, p)
    type(typeB), intent(out) :: this
    type(typeA), intent(in) :: p(:)
    allocate(this%p(size(p)))
    this%p = p
  end subroutine
end module
