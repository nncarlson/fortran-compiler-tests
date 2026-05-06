!https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125113
!!
!! SHMEM COARRAY SEGFAULT
!!
!! ICE with gfortran 16.1.0. With 17.0:
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 17.0.0 20260429 (experimental)
!!
!! $ gfortran -fcoarray=lib gfortran-20260429.f90 -lcaf_shmem
!!
!! $ GFORTRAN_NUM_IMAGES=2 ./a.out
!!
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!!
!! Backtrace for this error:
!! #0  0x7f4bd291244f in ???
!! #1  0x401949 in ???
!! #2  0x4021dd in ???
!! #3  0x40232c in ???
!! #4  0x7f4bd28fb447 in ???
!! #5  0x7f4bd28fb50a in ???
!! #6  0x401674 in ???
!! #7  0xffffffffffffffff in ???
!! ERROR: Image 2(pid: 1050402) failed with signal 11, exitstatus 0.
!!

integer, allocatable, target :: src(:)
integer :: dest(2)
integer :: i, first_gid, last_gid

type :: box
  integer, pointer :: data(:) => null()
end type
type(box), allocatable :: buffer[:]

if (this_image() == 1) then
  src = [(i, i = 1, 2*num_images())]
else
  allocate(src(0))
end if

first_gid = 1+2*(this_image()-1)
last_gid  = 2*this_image()

allocate(buffer[*])
buffer%data => src

sync all
dest = buffer[1]%data(first_gid:last_gid)
if (any(dest /= [first_gid, last_gid])) error stop

end
