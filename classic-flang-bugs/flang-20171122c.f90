!! https://github.com/flang-compiler/flang/issues/309
!!
!! The following example produces incorrect results.  The correct results are:
!!
!!  orig= 3 2 1 foobar
!!  copy= 3 2 1 foobar
!!
!! But the 2017-11-22 version (3b38c60) gives this:
!!
!!   $ flang flang-20171122c.f90 
!!   $ ./a.out
!!   orig= 3 2 1 foobar
!!   copy= 3 2 1 fo
!!

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
    allocate(copy, source=array)  ! SOMETHING GOES WRONG HERE
    select type (copy)
    type is (character(*))
      print '(a,3i2,1x,2a)', 'copy=', len(copy), shape(copy), copy
    end select
  end
end
