program main
  class(*), allocatable :: a, b
  allocate(a, source='')  !! No problem
  allocate(b, source=a)   !! Segfault
end program
