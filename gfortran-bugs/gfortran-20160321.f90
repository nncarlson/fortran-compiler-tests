character(:), allocatable :: array(:,:)
array = reshape(['foo','bar'],shape=[2,1])
call sub (array)
contains
  subroutine sub (array)
    class(*), intent(in) :: array(:,:)
    class(*), allocatable :: copy(:,:)
    select type (array)
    type is (character(*))
      print '(a,3i2,1x,2a)', 'orig=', len(array), shape(array), array
    end select
    allocate(copy, source=array)
    select type (copy)
    type is (character(*))
      print '(a,3i2,1x,2a)', 'copy=', len(copy), shape(copy), copy
    end select
  end
end
