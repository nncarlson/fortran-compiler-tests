program main
  use my_mod
  real(real64) :: vf(2,25)
  vf = 1.0_real64
  call use_count_with_dim (vf)
end program
