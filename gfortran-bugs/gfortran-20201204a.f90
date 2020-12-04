program main
  class(*), allocatable :: a, b, c
  character(len=0) :: s
  allocate(a, source=s)  !! No problem
  allocate(character(len=0)::b)
  allocate(c, source=b)  !! Segfault
end program
