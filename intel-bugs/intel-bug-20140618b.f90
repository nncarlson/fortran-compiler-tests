!!
!! The following code segfaults on a clearly valid DEALLOCATE statement.
!! Note that the error goes away if either the assignment statement or
!! the order of the components of T1 are swapped.
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort intel-bug-10240618b.f90 
!! % ./a.out
!!  Deallocating X%FOO ...
!! forrtl: severe (174): SIGSEGV, segmentation fault occurred
!! Image              PC                Routine            Line        Source             
!! a.out              0000000000472319  Unknown               Unknown  Unknown
!! a.out              0000000000470BEE  Unknown               Unknown  Unknown
!! a.out              0000000000426352  Unknown               Unknown  Unknown
!! a.out              0000000000406E33  Unknown               Unknown  Unknown
!! a.out              000000000040B9EB  Unknown               Unknown  Unknown
!! libpthread.so.0    0000003FA980F750  Unknown               Unknown  Unknown
!! a.out              0000000000404E4E  Unknown               Unknown  Unknown
!! a.out              0000000000402E0F  Unknown               Unknown  Unknown
!! a.out              0000000000402C96  Unknown               Unknown  Unknown
!! libc.so.6          0000003FA8C21D65  Unknown               Unknown  Unknown
!! a.out              0000000000402B89  Unknown               Unknown  Unknown
!!

program main

  type :: T1
    integer :: dim = 0
    class(*), allocatable :: bar
  end type

  type :: T2
    type(T1), allocatable :: foo
  end type
  
  type(T2) :: x
  
  allocate(x%foo)
  x%foo%dim = x%foo%dim + 1   ! NEEDED FOR THE SEGFAULT
  print *, 'Deallocating X%FOO ...'
  deallocate(x%foo)           ! <===  CODE SEGFAULTS ON THIS STATEMENT

end program
