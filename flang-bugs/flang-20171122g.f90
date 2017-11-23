!! https://github.com/flang-compiler/flang/issues
!!
!! Flang seems to be completely broken when it comes to pointer
!! rank remapping for CLASS(*) objects.
!!
!! Output from flang:
!! lbound=1 791621423, ubound=4 791621423, shape=4 0
!!
!! Expected output:
!! lbound=1 1, ubound=2 2, shape=2 2

program main
  class(*), allocatable, target :: array(:)
  class(*), pointer :: ptr(:,:)
  allocate(array, source=[1,2,3,4])
  ptr(1:2,1:2) => array
  print '(3(a,i0,1x,i0))', 'lbound=', lbound(ptr), ', ubound=', ubound(ptr), ', shape=', shape(ptr)
end program
