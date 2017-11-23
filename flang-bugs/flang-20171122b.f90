!! https://github.com/flang-compiler/flang/issues/308
!!
!! $ flang flang-20171122b.f90 
!! F90-F-0000-Internal compiler error. insert_sym: bad hash     685  (flang-20171122b.f90: 12)
!! F90/x86-64 Linux Flang - 1.5 2017-05-01: compilation aborted

character(3), target :: a = 'foo'
class(*), pointer :: b
b => ptr()
select type (b)
type is (character(*))
  print '(3a)', 'b="', b, '" (expect "foo")'
end select
contains
  function ptr()
    class(*), pointer :: ptr
    ptr => a
    select type (ptr)
    type is (character(*))
    end select
  end function
end
