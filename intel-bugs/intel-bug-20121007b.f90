!Issue number DPD200237182
!! FINALIZATION PERFORMED FOR A NON-FINALIZABLE DATA ENTITY
!!
!! In the following example a function returns a pointer to finalizable
!! derived type.  The result of the function reference, being a pointer,
!! is not finalizable however (1.3.76 and 4.5.6.2 item 1).  Yet this is
!! precisely what the Intel 13.0.0 compiler does when executing the
!! pointer assignment "obj => object_ptr()" -- the target is finalized
!! when it should not be.  This is evidenced by having the final
!! subroutine write a message.
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! 
!! % ifort intel-bug-20121007b.f90 
!! % ./a.out
!!  FINALIZER CALLED
!!  FINALIZER SHOULD NOT CALLED BEFORE THIS LINE
!!
 
module mod

  type :: object
  contains
    final :: delete_object
  end type
  
contains

  subroutine delete_object (this)
    type(object), intent(inout) :: this
    print *, 'FINALIZER CALLED'
  end subroutine
  
  !! Any function returning a TYPE(OBJECT) POINTER will do.
  function object_ptr () result (ptr)
    type(object), pointer :: ptr
    allocate(ptr)
  end function
    
end module

program main
  use mod
  type(object), pointer :: obj
  obj => object_ptr()
  print *, 'FINALIZER SHOULD NOT CALLED BEFORE THIS LINE'
end program
