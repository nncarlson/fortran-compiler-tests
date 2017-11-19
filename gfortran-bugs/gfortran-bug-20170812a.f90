!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79072#add_comment
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 7.2.1 20171028
!! 
!! $ gfortran gfortran-bug-20170812a.f90 
!! $ ./a.out
!! b="" (expect "foo")

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
  end function
end
