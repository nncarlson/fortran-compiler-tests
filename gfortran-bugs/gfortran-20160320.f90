!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67564
!! Fixed in 12.2.0 and probably much earlier

class(*), allocatable :: val(:)
call get_value (val)
select type (val)
type is (character(*))
  print '(2i2,1x,2a)', len(val), size(val), val ! expect 3 2 foobar
end select
contains
  subroutine get_value (value)
    class(*), allocatable, intent(out) :: value(:)
    allocate(value, source=['foo','bar'])
  end subroutine
end
