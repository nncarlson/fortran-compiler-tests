!! PR 84093
!!
!! This is a companion to gfortran-20180129.f90, which compilers should reject
!! with an error.  This is valid code which run without error, but doesn't with
!! gfortran 8.0 and earlier.
!!
!! $ gfortran gfortran-20180129.f90 
!! $ ./a.out
!! STOP 2

type parent
  type(parent), pointer :: next => null()
end type

type, extends(parent) :: child
  integer :: n
end type

type(child) :: c
type(parent), pointer :: p

allocate(p)
allocate(p%next)

c = child(parent=p,n=1)
if (.not.associated(c%next,p%next)) stop 1

c = child(p,1)
if (.not.associated(c%next,p)) stop 2

end
