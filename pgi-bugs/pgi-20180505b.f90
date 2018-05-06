!! INTERNAL COMPILER ERROR
!!
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem 
!! $ pgfortran pgi-20180505b.f90 
!! PGF90-F-0000-Internal compiler error. insert_sym: bad hash     639  (pgi-20180505b.f90: 14)
!! PGF90/x86-64 Linux 18.4-0: compilation aborted

character(3), target :: a = 'foo'
contains
  function ptr()
    class(*), pointer :: ptr
    ptr => a
    select type (ptr)
    type is (character(*))
    end select
  end function
end
