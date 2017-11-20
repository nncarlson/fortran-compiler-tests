!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79072
!!
!!
!! It gives correct results with 6.3:
!!            5 fubar
!!            5 fubar
!!
!! But incorrect results with 7.0 development branch:
!!            5 fubar
!!            0 

program main

  class(*), pointer :: x, y
  allocate(x, source='fubar')
  
  y => foobar(x)
  
  select type (y)
  type is (character(*))
    print '(i0,1x,a)', len(y), y
  end select

contains

  function foobar(bar) result(foo)
    class(*), pointer :: foo, bar
    foo => bar
    !select type (foo)
    !type is (character(*))
    !  print *, len(foo), foo
    !end select
  end function

end program
