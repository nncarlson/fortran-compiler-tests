!Issue number DPD200237439
!!
!! FILE POSITION NOT ADVANCED AS IT SHOULD DURING DATA TRANSFER
!! 
!! The following program writes the string 'abcdefghijkl' (no trailing newline)
!! to a file, opens the file for stream access, and reads the file in 8-character
!! chunks into a character array buffer.   While reading the second chunk the
!! EOF is encountered.  The read includes IOSTAT= to handle the EOF condition.
!! What I expect to have happened is for the data preceding the EOF to have been
!! successfully transferred into the initial elements of the buffer array and
!! for the file position to have been advanced up to the EOF.  This is the
!! behavior I see with a number of compilers (NAG, GFortran, PGI), but the
!! Intel 13.0 compiler behaves differently, and I believe incorrectly.
!! While the appropriate data is transfered into the initial elements of the
!! buffer array, the file position is not advanced.  Here's the expected output
!! of the program:
!!
!!  initial stream position= 1
!!  reading into 8-character buffer...
!!  current stream position= 9 , buffer length= 8
!!  buffer=abcdefgh
!!  reading into 8-character buffer...
!!  current stream position= 13 , buffer length= 4
!!  buffer=ijkl
!!
!! Here's the output using the Intel 13.0.0 compiler:
!!
!!  initial stream position=           1
!!  reading into 8-character buffer...
!!  current stream position=           9 , buffer length=           8
!!  buffer=abcdefgh
!!  reading into 8-character buffer...
!!  current stream position=           9 , buffer length=           0
!!  buflen=0, dumping contents of entire buffer
!!  buffer=ijklefgh
!!
!! According to 9.3.4.4.1, the file position should have been advanced
!! to the EOF after the second read.  But it was left at the position prior
!! to the read.
!!
!! I think this (incorrect) behavior may be based on a flawed understanding
!! of 9.11.3 (3) which says in part, "If an end-of-file condition occurs during
!! execution of an input/output statement that contains either an END= specifier
!! or an IOSTAT= specifier, and an error condition does not occur then: if the
!! statement is a READ statement [...] all input list items or namelist group
!! objects in the statement that initiated the transfer become undefined".
!! Each item in the input list initiates its own data transfer, in order,
!! and each element of the buffer array is considered an effective item (see
!! 9.6.3, par 7 (bullet 1) and par 8).  Consequently, data transfer should
!! have completed successfully for the initial elements of the buffer array
!! and the file position advanced accordingly.
!!

program main

  use,intrinsic :: iso_fortran_env

  integer, parameter :: unit = 10
  character :: buffer(8)
  integer buflen, last_pos, curr_pos, ios
  
  !! Create a file to read.
  open(unit,file='input.txt',access='stream',action='write',status='replace',form='unformatted')
  write(unit) 'abcdefghijkl'
  close(unit)
  
  open(unit,file='input.txt',access='stream',action='read',form='unformatted')
  inquire(unit,pos=last_pos)
  print *, 'initial stream position=', last_pos
  
  !! Read the file in 8-character chunks.
  do
    print *, 'reading into 8-character buffer...'
    read(unit,iostat=ios) buffer
    if (ios /= 0 .and. ios /= iostat_end) then
      print *, 'read error: iostat=', ios
      exit
    end if
    inquire(unit,pos=curr_pos)
    buflen = curr_pos - last_pos
    print '(2(a,i0))', 'current stream position=', curr_pos, ', buffer length=', buflen
    last_pos = curr_pos
    if (buflen > 0) then
      print '(9a)', 'buffer=', buffer(:buflen)
    else
      print '(a)', 'buflen=0, dumping contents of entire buffer'
      print '(9a)', 'buffer=', buffer
    end if
    if (ios == iostat_end) exit
  end do
  
end program
