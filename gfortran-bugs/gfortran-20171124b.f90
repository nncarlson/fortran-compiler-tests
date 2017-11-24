!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49213
!!
!! Another case of gfortran-bug-20110616.f90.  GFortran seems to be
!! fundamentally broken when it comes to derived types with polymorphic 
!! pointer components and intrinsic structure constructors.
!!
!! $ gfortran gfortran-20171124b.f90 
!! gfortran-20171124b.f90:6:13:
!! 
!!  call sub(box(n))
!!              1
!! Error: Can't convert INTEGER(4) to CLASS(*) at (1)

type box
  class(*), pointer :: uptr => null()
end type
integer, target :: n
call sub(box(n))
contains
  subroutine sub(b)
    type(box), intent(in) :: b
  end subroutine
end
