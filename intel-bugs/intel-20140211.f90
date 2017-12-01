!!
!! C_NULL_PTR PASSED INCORRECTLY WITH -standard-semantics OPTION
!!
!! The following example calls a C function with a void* argument, once passing
!! an associated TYPE(C_PTR) actual, and once passing C_NULL_PTR. When compiled
!! with ifort 13.1.2 and the -standard-semantics option the example executes as
!! expected, but with 14.0.1 the C function is receiving a non NULL pointer in
!! the latter case, which is incorrect.  The example runs correctly when the
!! -standard-semantics option is omitted.  Here are the results for the two
!! compiler versions:
!!
!! % ifort --version
!! ifort (IFORT) 13.1.2 20130514
!! % icc -c intel-bug-20140211-C.c
!! % ifort -standard-semantics intel-bug-20140211.f90 intel-bug-20140211-C.o 
!! % ./a.out
!!  passing c_loc(arg) to C_function
!! 	arg pointer is not NULL in c_function; arg=42
!!  passing c_null_ptr to C_function
!! 	arg pointer is NULL in c_function             <=== THIS IS RIGHT
!!
!! % ifort --version
!! ifort (IFORT) 14.0.1 20131008
!! % icc -c intel-bug-20140211-C.c 
!! % ifort -standard-semantics intel-bug-20140211.f90 intel-bug-20140211-C.o 
!! % ./a.out
!!  passing c_loc(arg) to C_function
!! 	arg pointer is not NULL in c_function; arg=42
!!  passing c_null_ptr to C_function
!! 	arg pointer is not NULL in c_function; arg=0  <=== THIS IS WRONG
!!

program main
  use :: iso_c_binding
  interface
    subroutine c_function(arg) bind(c)
      import c_ptr
      type(c_ptr), value :: arg
    end subroutine
  end interface
  integer, target :: arg = 42
  print *, 'passing c_loc(arg) to C_function'
  call c_function (c_loc(arg))
  print *, 'passing c_null_ptr to C_function'
  call c_function (c_null_ptr)
end program

! #include <stdio.h>
! void c_function (void *arg) {
!   if (arg == NULL)
!       printf("\targ pointer is NULL in c_function\n");
!   else
!       printf("\targ pointer is not NULL in c_function; arg=%d\n",*(int*)arg);
! }
