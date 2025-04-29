!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114827
!! Fixed in gfortran 14.2.0
!!
!! BAD CODE
!!
!! GFortran generates bad memory-stompiong code for the following example.
!!
!! $ gfortran -g -O0 -fsanitize=address gfortran-20240425.f90
!!
!! $ ./a.out
!! =================================================================
!! ==1345119==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x602000000071 at pc 0x7f69f444c8d1 bp 0x7fff957c8090 sp 0x7fff957c7840
!! WRITE of size 27 at 0x602000000071 thread T0
!!     #0 0x7f69f444c8d0 in __interceptor_memmove ../../../../libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:810
!!     #1 0x4012d4 in __copy_character_1 /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:36
!!     #2 0x401711 in foo /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:46
!!     #3 0x4019a9 in run /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:41
!!     #4 0x40137e in MAIN__ /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:37
!!     #5 0x401c76 in main /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:37
!!     #6 0x7f69f3e46149 in __libc_start_call_main (/lib64/libc.so.6+0x28149)
!!     #7 0x7f69f3e4620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a)
!!     #8 0x401184 in _start (/home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/a.out+0x401184)
!!
!! 0x602000000071 is located 0 bytes to the right of 1-byte region [0x602000000070,0x602000000071)
!! allocated by thread T0 here:
!!     #0 0x7f69f44bd69f in __interceptor_malloc ../../../../libsanitizer/asan/asan_malloc_linux.cpp:69
!!     #1 0x4014ff in foo /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:46
!!     #2 0x4019a9 in run /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:41
!!     #3 0x40137e in MAIN__ /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:37
!!     #4 0x401c76 in main /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20240425.f90:37
!!     #5 0x7f69f3e46149 in __libc_start_call_main (/lib64/libc.so.6+0x28149)
!!     #6 0x7f69f3e4620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a)
!!     #7 0x401184 in _start (/home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/a.out+0x401184)
!!
!! SUMMARY: AddressSanitizer: heap-buffer-overflow ../../../../libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:810 in __interceptor_memmove

program main
  call run
contains
  subroutine run
    class(*), allocatable :: y
    call foo('fubarfubarfubarfubarfubarfu', y)
  end subroutine 
  subroutine foo(a, b)
    class(*), intent(in) :: a
    class(*), allocatable :: b
    b = a
    !allocate(b, source=a) ! VALGRIND REPORTS NO INVALID WRITES WITH THIS
  end subroutine
end program
