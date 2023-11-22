!! CMPLRLLVM-53862
!!
!! UNFORMATTED STREAM READ INTO CHARACTER POINTER BUFFER
!!
!! The following example reads ascii text from a file using unformatted stream
!! input. The data is read into a character array buffer.  If that buffer is
!! an allocated allocatable array the read works as expected.  However if the
!! buffer is an allocated pointer array the buffer is filled with random
!! garbage, using both Intel 17.0.6 and 18.0.1.
!! 
!! $ ifort --version
!! ifort (IFORT) 17.0.6 20171215
!! 
!! $ ifort intel-20180221.f90 
!! $ ./a.out
!!           40 one fish, two fish, red fish, blue fish
!! 
!!           40 8\ufffd(q8\ufffd(q

program main

  use,intrinsic :: iso_fortran_env, only: iostat_end
  integer :: lun, ios, pos1, pos2, n
  character, allocatable :: buffer1(:)
  character, pointer :: buffer2(:)
  character(*), parameter :: string = 'one fish, two fish, red fish, blue fish'
  character, allocatable :: array(:)
  
  open(newunit=lun,file='junk')
  write(lun,'(a)') string
  close(lun)
  
  array = transfer(string, 'a', len(string))
  n = size(array)
  
  !! Read into allocatable character buffer -- THIS WORKS
  open(newunit=lun,file='junk',action='read',access='stream',iostat=ios)
  inquire(lun,pos=pos1)
  allocate(buffer1(100))
  read(lun,iostat=ios) buffer1
  if (ios /= iostat_end) stop 1
  inquire(lun,pos=pos2)
  n = pos2 - pos1
  !print *, n, buffer1(:n)
  if (n /= size(array)+1) stop 2
  if (any(buffer1(:size(array)) /= array)) stop 3
  close(lun)
  
  !! Read into pointer character buffer -- THIS READS RANDOM GARBAGE
  open(newunit=lun,file='junk',action='read',access='stream',iostat=ios)
  inquire(lun,pos=pos1)
  allocate(buffer2(100))
  read(lun,iostat=ios) buffer2
  if (ios /= iostat_end) stop 4
  inquire(lun,pos=pos2)
  n = pos2 - pos1
  !print *, n, buffer2(:n)
  if (n /= size(array)+1) stop 5
  if (any(buffer2(:size(array)) /= array)) stop 6
  close(lun)

end program
