!! https://gcc.gnu.org/bugzilla/show_bug.cgi?format=multiple&id=117897
!! https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=3b6ed0c74139faed62b7d60804521aed67e40b2b
!! Affects gfortran between 13.1 and 14.2
!!
!! BAD CODE
!!
!! GFortran generates two calls to node_constructor inside node_copy.
!!
!! $ gfortran -O0 -g -fsanitize=address gfortran-20250806.f90
!!
!! $ ./a.out
!! =================================================================
!! ==58==ERROR: AddressSanitizer: unknown-crash on address 0x7f2047b00020 at pc 0x0000004012da bp 0x7ffe2273d880 sp 0x7ffe2273d878
!! WRITE of size 24 at 0x7f2047b00020 thread T0
!!     #0 0x4012d9 in __node_m_MOD___copy_node_m_Node_t /tmp/gfortran-20250806.f90:57
!!     #1 0x40152c in __node_m_MOD_node_copy /tmp/gfortran-20250806.f90:55
!!     #2 0x401b07 in test /tmp/gfortran-20250806.f90:64
!!     #3 0x401fc6 in main /tmp/gfortran-20250806.f90:60
!!     #4 0x7f2049d2e249 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
!!     #5 0x7f2049d2e304 in __libc_start_main_impl ../csu/libc-start.c:360
!!     #6 0x4011a0 in _start (/tmp/a.out+0x4011a0)
!!
!! Address 0x7f2047b00020 is located in stack of thread T0 at offset 32 in frame
!!     #0 0x40136d in __node_m_MOD_node_copy /tmp/gfortran-20250806.f90:51
!!
!!   This frame has 3 object(s):
!!     [32, 48) '__result_node_copy' (line 51) <== Memory access at offset 32 partially overflows this variable
!!     [64, 80) '<unknown>'
!!     [96, 120) 'value.0' (line 55)
!! HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
!!       (longjmp and C++ exceptions *are* supported)
!! SUMMARY: AddressSanitizer: unknown-crash /tmp/gfortran-20250806.f90:57 in __node_m_MOD___copy_node_m_Node_t

module node_m
  implicit none

  type :: node_t
    private
    class(*), pointer :: value => null()
  end type node_t

contains
  function node_constructor(value) result(constructor)
    class(*),      target  :: value
    class(node_t), pointer :: constructor

    allocate(constructor)
    constructor%value => value
  end function node_constructor

  function node_copy(this)
    class(node_t), target  :: this
    class(node_t), pointer :: node_copy

    node_copy => node_constructor(this%value)
  end function node_copy
end module node_m

program test
  use node_m
  class(node_t), pointer :: node1, node2
  integer(8) :: value
  node1 => node_constructor(value)
  node2 => node_copy(node1)
  deallocate(node1)
  deallocate(node2)
end program test
