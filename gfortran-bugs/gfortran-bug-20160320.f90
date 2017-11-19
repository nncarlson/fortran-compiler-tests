!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67564
!!

class(*), allocatable :: val(:)
call get_value (val)
select type (val)
type is (character(*))
  print '(a,i0,a)', 'size=', size(val), ' (expect 2)'
  print '(a,i0,a)', 'len=', len(val), ' (expect 3)'
  print '(4a)', 'val=', val, ' (expect foobar)'
end select
contains
  subroutine get_value (value)
    class(*), allocatable, intent(out) :: value(:)
    allocate(value, source=['foo','bar'])
  end subroutine
end
