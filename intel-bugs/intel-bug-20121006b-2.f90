program main
  use mod
  use,intrinsic :: iso_c_binding, only: c_long_long
  call sub (int(1_c_long_long))
  !n = 1_c_long_long
  !call sub (n)
end program
