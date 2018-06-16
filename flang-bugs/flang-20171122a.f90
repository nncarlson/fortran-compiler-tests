!! https://github.com/flang-compiler/flang/issues/307
!! This example now executes correctly with 543785e7 (20180615)
!!
!! $ flang flang-20171122a.f90 
!! /tmp/flang-20171122a-6ad8d1.o: In function `MAIN_':
!! flang-20171122a.f90:6: undefined reference to `__f03_unl_poly_0____td_'
!! clang-5.0: error: linker command failed with exit code 1 (use -v to see invocation)

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
