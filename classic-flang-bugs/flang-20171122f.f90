!! https://github.com/flang-compiler/flang/issues/310
!!
!! POINTER ASSIGNMENT NOT DEFINING DEFERRED LENGTH PARAMETER
!!
!! In the following example, the second pointer assignment involving
!! rank remapping is not properly defining the deferred length parameter
!! of the pointer object (see F2008 5.3.14 #3).  Key to the error is
!! that the target is a deferred-length allocatable
!!
!! $ flang flang-20171122f.f90 
!! $ ./a.out
!! len1=3 (expect 3)
!! len2=65538 (expect 3)

program main
  character(:), allocatable, target :: array(:)
  character(:), pointer :: ptr1(:), ptr2(:,:)
  allocate(array(1), source=['foo'])
  ptr1 => array             ! THIS WORKS
  print '(a,2(i0,a))', 'len1=', len(ptr1), ' (expect ', len(array), ')'
  ptr2(1:1,1:1) => array    ! THIS DOES NOT WORK
  print '(a,2(i0,a))', 'len2=', len(ptr2), ' (expect ', len(array), ')'
end program
