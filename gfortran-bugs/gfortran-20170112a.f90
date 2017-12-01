!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79072
!! fixed in 254966 (2017-11-20)
!! 
!! This example gives an ICE with the current 7.0 trunk and all 6.x releases
!! 
!! The ICE disappears if either:
!! 1) type is (character(*)) is replaced with integer, for example;
!! 2) the return variable is specified in a result(...) clause.
!! 

function foo()
  class(*), pointer :: foo
  character(3), target :: string = 'foo'
  foo => string
  select type (foo)
  type is (character(*))
    !print *, foo
  end select
end function
