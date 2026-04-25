!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125021
!! INTERNAL COMPILER ERROR: COARRAY
!!
!! With gfortran 16.0.1:
!!
!! gfortran -fcoarray=lib gfortran-20260425.f90 -lcaf_shmem
!! $ gfortran-20260425.f90:12:4:
!!
!!    12 | n = buffer[i]%data(1)
!!       |    1
!! internal compiler error: in gfc_conv_component_ref, at fortran/trans-expr.cc:3002

type box
  integer, allocatable :: data(:)
end type
type(box), allocatable :: buffer[:]

integer :: i, n

allocate(buffer[*])
allocate(buffer%data(1), source=this_image())
sync all

i = 1 + modulo(this_image(), num_images())
n = buffer[i]%data(1)
if (n /= i ) error stop
end
