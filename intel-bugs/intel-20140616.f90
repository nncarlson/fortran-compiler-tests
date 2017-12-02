!Issue number DPD200357656
!!
!! INCORRECT RESULTS
!!
!! The following example produces incorrect results.
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort intel-bug-20140616.f90 
!! % ./a.out
!!  expect 1 2 3 4:           1           2           3           4
!!  expect 1 3:   538976288   538976288
!!  expect 2 4:   538976288   538976288
!!  expect 1 2:           1           2
!!  expect 3 4:           1           2
!!

program main

  class(*), allocatable, target :: array(:)
  class(*), pointer :: ptr(:,:)
  
  allocate(array, source=[1,2,3,4])
  
  ptr(1:2,1:2) => array
  
  select type (ptr)
  type is (integer)
    print *, 'expect 1 2 3 4:', ptr
    print *, 'expect 1 3:', ptr(1,:)
    print *, 'expect 2 4:', ptr(2,:)
    print *, 'expect 1 2:', ptr(:,1)
    print *, 'expect 3 4:', ptr(:,2)
    if (all(ptr(1,:) == [1,3]) .and. all(ptr(2,:) == [2,4]) .and. &
        all(ptr(:,1) == [1,2]) .and. all(ptr(:,2) == [3,4])) then
      print *, 'pass'
    else
      print *, 'fail'
    end if
  end select
  
end program
