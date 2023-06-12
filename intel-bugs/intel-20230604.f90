!! CMPLRLLVM-48376
!!
!! WRONG RESULT FROM COINDEXED ACTUAL ARGUMENT TO MATMUL
!!
!! This example exposes an error with the executable code for a MATMUL
!! reference when one of its actual arguments is a multirank coindexed
!! object.  The example compares the result of that MATMUL with the
!! value computed by first assigning the coindexed object to a local
!! array and passing it instead. The error occurs for both ifort 2021.9
!! and ifx 2023.1
!!
!! $ ifort -coarray -coarray-num-images=2 bug.f90
!! $ ./a.out
!!  error on image 1
!!  c1= 2.000000 4.000000 6.000000 8.000000
!!  c2= 4.000000 2.000000 8.000000 6.000000
!!

program main
  real :: a(2,2), b(2,2)[*], c1(2,2), c2(2,2), tmp(2,2)
  a = reshape([0,1,1,0], shape=[2,2])
  b = this_image()*reshape([1,2,3,4], shape=[2,2])
  sync all
  if (this_image() < num_images()) then
    c1 = matmul(a, b(:,:)[this_image()+1]) ! EXCHANGES ROWS OF B
    tmp = b(:,:)[this_image()+1]
    c2 = matmul(a, tmp)
    if (any(c1 /= c2)) then
      print *, 'error on image', this_image()
      print *, 'c1=', c1
      print *, 'c2=', c2
      error stop
    end if
  end if
end program
