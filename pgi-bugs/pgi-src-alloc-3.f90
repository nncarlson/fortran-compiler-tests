!! SEG FAULT IN SOURCED ALLOCATION
!!
!! The following example almost always will segfault on the sourced allocation
!! statement.
!!
!! $ pgfortran --version
!! pgfortran 18.10-0 64-bit target on x86-64 Linux -tp haswell
!!
!! $ pgfortran -g pgi-src-alloc-3.f90
!! $ ./a.out
!! Segmentation fault (core dumped)
!!

type, abstract :: json_value
end type

type, extends(json_value) :: json_string
  character(:), allocatable :: value
end type

class(json_value), allocatable :: x

call foo('fubar', x)
select type (x)
type is (json_string)
  if (x%value /= 'fubar') stop 1
class default
  stop 2
end select

contains

  subroutine foo(string, x)
    character(*), intent(in) :: string
    class(json_value), allocatable, intent(out) :: x
    allocate(x, source=json_string(string))  ! <== SEG FAULTS HERE
  end subroutine

end

!! Output from valgrind. See final error
!!
!! $ valgrind ./a.out
!! ==22105== Memcheck, a memory error detector
!! ==22105== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
!! ==22105== Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyright info
!! ==22105== Command: ./a.out
!! ==22105==
!! ==22105== Conditional jump or move depends on uninitialised value(s)
!! ==22105==    at 0x52BCC05: pgf90_get_object_size (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE50A: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Use of uninitialised value of size 8
!! ==22105==    at 0x52BCC0B: pgf90_get_object_size (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE50A: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Conditional jump or move depends on uninitialised value(s)
!! ==22105==    at 0x52BCC05: pgf90_get_object_size (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52476F6: pgf90_ptr_src_alloc03a (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52477FF: pgf90_ptr_src_alloc03 (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE55C: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Use of uninitialised value of size 8
!! ==22105==    at 0x52BCC0B: pgf90_get_object_size (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52476F6: pgf90_ptr_src_alloc03a (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52477FF: pgf90_ptr_src_alloc03 (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE55C: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Invalid read of size 8
!! ==22105==    at 0x4C3445E: memmove (vg_replace_strmem.c:1252)
!! ==22105==    by 0x583232A: __fort_bcopy (in /opt/pgi/linux86-64/18.10/lib/libpgf902.so)
!! ==22105==    by 0x52BE57C: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==  Address 0x7450110 is 0 bytes after a block of size 32 alloc'd
!! ==22105==    at 0x4C2DB9D: malloc (vg_replace_malloc.c:299)
!! ==22105==    by 0x525C47E: __fort_malloc_without_abort (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x525C6A4: __fort_gmalloc_without_abort (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x5249346: __alloc04 (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52469C0: pgf90_alloc04a (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x5246A3F: pgf90_alloc04 (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x5246C7C: pgf90_alloc04_chka (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x40121D: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Invalid read of size 8
!! ==22105==    at 0x4C34450: memmove (vg_replace_strmem.c:1252)
!! ==22105==    by 0x583232A: __fort_bcopy (in /opt/pgi/linux86-64/18.10/lib/libpgf902.so)
!! ==22105==    by 0x52BE57C: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==  Address 0x7450128 is 24 bytes after a block of size 32 in arena "client"
!! ==22105==
!! ==22105== Conditional jump or move depends on uninitialised value(s)
!! ==22105==    at 0x52BE42A: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE5B9: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Use of uninitialised value of size 8
!! ==22105==    at 0x52BE430: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE5B9: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Use of uninitialised value of size 8
!! ==22105==    at 0x52BE450: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE5B9: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==
!! ==22105== Invalid read of size 4
!! ==22105==    at 0x52BE454: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE5B9: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==22105==  Address 0x6021a900000000 is not stack'd, malloc'd or (recently) free'd
!! ==22105==
!! ==22105==
!! ==22105== Process terminating with default action of signal 11 (SIGSEGV): dumping core
!! ==22105==  General Protection Fault
!! ==22105==    at 0x52BE454: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BE5B9: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x52BD396: pgf90_poly_asn (in /opt/pgi/linux86-64/18.10/lib/libpgf90.so)
!! ==22105==    by 0x4012CA: MAIN_foo (pgi-src-alloc-3.f90:33)
!! ==22105==    by 0x400FAD: MAIN_ (pgi-src-alloc-3.f90:20)
!! ==22105==    by 0x400EF3: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
