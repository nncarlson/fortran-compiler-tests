!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54070
!! this example marked a duplicate of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=50221
!!
!! Compiles with 5.2 and 6.0 20151025, but both return the wrong result:
!! barbar (expect "foobar")
!!

program main
  character(:), pointer :: s(:)
  allocate(character(3)::s(2))
  s(1) = 'foo'; s(2) = 'bar'
  print '(2a)', s ! expect foobar
end program
