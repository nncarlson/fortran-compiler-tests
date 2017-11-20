!! fixed in 5.3.2 (989) -- Issue number 88549
!!
!! POINTER ASSIGNMENT NOT DEFINING DEFERRED LENGTH PARAMETER
!!
!! In the following example, the second pointer assignment involving
!! rank remapping is not properly defining the deferred length parameter
!! of the pointer object (see F2008 5.3.14 #3).
!!
!! The code works correctly if ARRAY is declared as CHARACTER(:) and the
!! SELECT-TYPE construct eliminated.
!!
!! % nagfor nag-bug-20140617.f90 
!! NAG Fortran Compiler Release 5.3.2(983)
!! [NAG Fortran Compiler normal termination]
!! % ./a.out
!!  len= 3  (expect 3 )
!!  len= 0  (expect 3 )     <=== THIS IS WRONG
!!

program main
  class(*), allocatable, target :: array(:)
  character(:), pointer :: ptr1(:), ptr2(:,:)
  allocate(array(1), source=['foo'])
  select type (array)
  type is (character(*))
    !ptr1 => array             ! THIS WORKS
    !print *, 'len=', len(ptr1), ' (expect', len(array), ')'
    ptr2(1:1,1:1) => array    ! THIS DOES NOT WORK
    print '(a,2(i0,a))', 'len=', len(ptr2), ' (expect ', len(array), ')'
  end select
end program
