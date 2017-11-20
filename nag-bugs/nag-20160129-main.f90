program main

  use a_type
  type(a) :: x, y(2)

  call x%sub ([1,2])
  call y%sub ([1,2])

  print *, x%n, '(expect 3)'
  print *, y%n, '(expect 1 2)'

end program

