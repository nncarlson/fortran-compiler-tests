!! https://github.com/flang-compiler/flang/issues/254
!! Fixed in the 20190329 release
!!
!! Right shift of bits.  0 should move in from left.
!!
!! Expected output:
!!
!! $ ./a.out
!! -44=11010100
!! 106=01101010
!!
!! Output from flang:
!!
!! $ ./a.out
!! -44=11010100
!! -22=11101010

program main
  use,intrinsic :: iso_fortran_env
  integer(int8) :: digest
  digest = -44_int8
  write(*,'(i0,"=",b8.8)') digest, digest
  digest = ishft(digest,-1)
  write(*,'(i0,"=",b8.8)') digest, digest
end program
