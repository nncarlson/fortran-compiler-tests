character(:), allocatable :: array(:,:)
array = reshape(['foo','bar'],shape=[2,1])
call sub (array)
contains
  subroutine sub (array)
    class(*), intent(in) :: array(:,:)
    class(*), allocatable :: copy(:,:)
    select type (array)
    type is (character(*))
      print '(3i2,1x,3a)', len(array), shape(array), array, ' (expect 3 2 1 foobar)'
    end select
    allocate(copy, source=array)
    select type (copy)
    type is (character(*))
      print '(3i2,1x,3a)', len(copy), shape(copy), copy, ' (expect 3 2 1 foobar)'
    end select
  end
end
