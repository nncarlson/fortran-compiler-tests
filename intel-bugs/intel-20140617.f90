!!
!! POINTER ASSIGNMENT NOT DEFINING DEFERRED LENGTH PARAMETER
!!
!! In the following example, the second pointer assignment involving
!! rank remapping is not properly defining the deferred length parameter
!! of the pointer object (see F2008 5.3.14 #3).  Key to the error is
!! that the target is a deferred-length allocatable
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort intel-bug-20140617.f90 
!! % ./a.out
!!  len=           3  (expect           3 )
!!  len=           0  (expect           3 )   <== THIS IS WRONG
!!

program main
  character(:), allocatable, target :: array(:)
  character(:), pointer :: ptr1(:), ptr2(:,:)
  allocate(array(1), source=['foo'])
  ptr1 => array             ! THIS WORKS
  print *, 'len=', len(ptr1), ' (expect', len(array), ')'
  ptr2(1:1,1:1) => array    ! THIS DOES NOT WORK
  print *, 'len=', len(ptr2), ' (expect', len(array), ')'
  if (len(ptr2) == 3) then
    print *, 'pass'
  else
    print *, 'fail'
  end if
end program
