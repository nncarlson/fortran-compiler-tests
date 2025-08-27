!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=121683
!!
!! WRONG CODE
!!
!! When run with the sanitizer enabled, its output indicates that
!! the ALLOCATE statement is causing the default finalizer for T1
!! to be called on the variable X, which is wrong. Gfortran 15.2.0
!!
!! $ gfortran -g -fsanitize=address gfortran-20250826.f90
!! $ ./a.out
!! =================================================================
!! ==2538836==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b2bb91e0070 at pc 0x000000402681 bp 0x7ffd2c624530 sp 0x7ffd2c624528
!! READ of size 4 at 0x7b2bb91e0070 thread T0
!!     #0 0x000000402680 in MAIN__ /tmp/gfortran-20250826.f90:20
!!     #1 0x000000402a09 in main /tmp/gfortran-20250826.f90:22
!!     #2 0x7f0bba446149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: 1cd2d1016ef987f11f5709c2aa0deb4520dcc851)
!!     #3 0x7f0bba44620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: 1cd2d1016ef987f11f5709c2aa0deb4520dcc851)
!!     #4 0x0000004011f4 in _start (/tmp/a.out+0x4011f4)
!!
!! 0x7b2bb91e0070 is located 0 bytes inside of 8-byte region [0x7b2bb91e0070,0x7b2bb91e0078)
!! freed by thread T0 here:
!!     #0 0x7f0bbab20a6b in free ../../../../libsanitizer/asan/asan_malloc_linux.cpp:51
!!     #1 0x000000401c40 in __final_main_T1 /tmp/gfortran-20250826.f90:1
!!     #2 0x000000402525 in MAIN__ /tmp/gfortran-20250826.f90:17
!!     #3 0x000000402a09 in main /tmp/gfortran-20250826.f90:22
!!     #4 0x7f0bba446149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: 1cd2d1016ef987f11f5709c2aa0deb4520dcc851)
!!     #5 0x7f0bba44620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: 1cd2d1016ef987f11f5709c2aa0deb4520dcc851)
!!     #6 0x0000004011f4 in _start (/tmp/a.out+0x4011f4)
!!
!! previously allocated by thread T0 here:
!!     #0 0x7f0bbab21dab in malloc ../../../../libsanitizer/asan/asan_malloc_linux.cpp:67
!!     #1 0x000000401f5d in MAIN__ /tmp/gfortran-20250826.f90:16
!!     #2 0x000000402a09 in main /tmp/gfortran-20250826.f90:22
!!     #3 0x7f0bba446149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: 1cd2d1016ef987f11f5709c2aa0deb4520dcc851)
!!     #4 0x7f0bba44620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: 1cd2d1016ef987f11f5709c2aa0deb4520dcc851)
!!     #5 0x0000004011f4 in _start (/tmp/a.out+0x4011f4)
!!
!! SUMMARY: AddressSanitizer: heap-use-after-free /tmp/gfortran-20250826.f90:20 in MAIN__
!! Shadow bytes around the buggy address:
!!   0x7b2bb91dfd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
!!   0x7b2bb91dfe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
!!   0x7b2bb91dfe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
!!   0x7b2bb91dff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
!!   0x7b2bb91dff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
!! =>0x7b2bb91e0000: fa fa 06 fa fa fa 07 fa fa fa 07 fa fa fa[fd]fa
!!   0x7b2bb91e0080: fa fa 00 00 fa fa 00 fa fa fa fd fa fa fa fd fa
!!   0x7b2bb91e0100: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
!!   0x7b2bb91e0180: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
!!   0x7b2bb91e0200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
!!   0x7b2bb91e0280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
!! Shadow byte legend (one shadow byte represents 8 application bytes):
!!   Addressable:           00
!!   Partially addressable: 01 02 03 04 05 06 07
!!   Heap left redzone:       fa
!!   Freed heap region:       fd
!!   Stack left redzone:      f1
!!   Stack mid redzone:       f2
!!   Stack right redzone:     f3
!!   Stack after return:      f5
!!   Stack use after scope:   f8
!!   Global redzone:          f9
!!   Global init order:       f6
!!   Poisoned by user:        f7
!!   Container overflow:      fc
!!   Array cookie:            ac
!!   Intra object redzone:    bb
!!   ASan internal:           fe
!!   Left alloca redzone:     ca
!!   Right alloca redzone:    cb
!! ==2538836==ABORTING

program main

  type, abstract :: base
  end type

  type, extends(base) :: t1
    integer, allocatable :: array(:)
  end type
  type(t1) :: x

  type :: t2
    class(base), allocatable :: b
  end type
  type(t2), allocatable :: y

  x%array = [1,2]
  allocate(y, source=t2(x))
  if (.not.allocated(x%array)) stop 1
  if (size(x%array) /= 2) stop 2
  if (any(x%array /= [1,2])) stop 3

end program
