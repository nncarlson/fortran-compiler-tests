!Issue number DPD200237219
!!
!! SOURCED-ALLOCATION DOESN'T ALLOCATE POINTER IN CERTAIN CASES
!!
!! This example shows that the Intel 13.0.0 compiler generates bad object
!! code for a particular sourced-allocation statement.  The code output
!! from the print statement and diagnostic output from -C indicate that
!! the pointer COPY simply isn't allocated by the ALLOCATE statement.
!! Examining things in the debugger appears to support this.
!!
!! This error seems to be triggered when the pointer is a derived type
!! with an allocatable CLASS(*) component; the error disappears if that
!! component is removed or replaced with something different.  It also
!! seems to depend on the pointer being the function result; if a local
!! pointer is allocated instead, and then the function result pointer
!! assigned to it, the allocation is successful.
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! 
!! % ifort -g -C intel-bug-20121008.f90 
!! 
!! % ./a.out
!!  ERROR: COPY NOT ALLOCATED
!! forrtl: severe (408): fort: (7): Attempt to use pointer COPY when it is not associated with a target
!! 
!! Image              PC                Routine            Line        Source             
!! a.out              000000000046D60E  Unknown               Unknown  Unknown
!! a.out              000000000046C0A6  Unknown               Unknown  Unknown
!! a.out              0000000000425052  Unknown               Unknown  Unknown
!! a.out              0000000000406AAB  Unknown               Unknown  Unknown
!! a.out              0000000000406FC1  Unknown               Unknown  Unknown
!! a.out              0000000000402DE7  Unknown               Unknown  Unknown
!! a.out              0000000000403059  Unknown               Unknown  Unknown
!! a.out              0000000000402B4C  Unknown               Unknown  Unknown
!! libc.so.6          0000003F03C21735  Unknown               Unknown  Unknown
!! a.out              0000000000402A29  Unknown               Unknown  Unknown
!!

module foo_type

  type :: foo
    integer :: n
    class(*), allocatable :: value
  end type
  
contains

  function copy_item (item) result (copy)
    type(foo), intent(in) :: item
    type(foo), pointer :: copy
    allocate(copy, source=item) ! SOMETHING IS GOING WRONG HERE
    if (.not.associated(copy)) print *, 'ERROR: COPY NOT ALLOCATED'
    copy%n = 1  ! USE IT TO TRIGGER A SEGFAULT IF NOT ALLOCATED
  end function
  
end module

program main
  use foo_type
  type(foo) :: x
  type(foo), pointer :: y
  !! THIS SOURCED-ALLOCATION APPEARS TO WORK.
  allocate(y, source=x)
  if (.not.associated(y)) print *, 'ERROR: Y NOT ALLOCATED'
  !! BUT THIS SOURCED-ALLOCATION WRAPPED IN A FUNCTION DOES NOT.
  y => copy_item(x)
end program
