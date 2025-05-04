! https://github.com/flang-compiler/flang/issues/253
! Fixed in the 20190329 release

program main

  use,intrinsic :: iso_fortran_env
  
  call int8_arg(iand(1_int8,1_int8))
  call int8_arg(ibset(1_int8,1))
  call int8_arg(ieor(1_int8,1_int8))
  call int8_arg(ior(1_int8,1_int8))
  call int8_arg(ishft(1_int8,1))
  call int8_arg(not(1_int8))

contains

  subroutine int8_arg(n)
    integer(int8) :: n
  end subroutine

end program
