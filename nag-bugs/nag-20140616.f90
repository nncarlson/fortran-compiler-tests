!! fixed in 5.3.2 (989) -- Issue number 88538
!!
!! Internal Compiler Error
!!
!! The following example triggers an internal compiler error with
!! the NAG 5.3.2 (983) compiler.  I believe it is standard conforming.
!!
!! % nagfor nag-bug-20140616.f90 
!! NAG Fortran Compiler Release 5.3.2(983)
!! Panic: nag-bug-20140616.f90: Unknown data type (0,0) in cdtype_size
!! Internal Error -- please report this bug
!! Abort
!!

program main
  class(*), allocatable, target :: array(:)
  class(*), pointer :: ptr(:,:)
  allocate(array(4), source=[1,2,3,4])
  ptr(1:2,1:2) => array   ! <=== STATEMENT THAT CAUSES THE ICE
  select type (ptr)
  type is (integer)
    print *, ptr
  end select
end program
