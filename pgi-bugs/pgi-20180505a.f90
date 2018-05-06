!! SEGFAULT ON POLYMORPHIC SOURCED ALLOCATION
!!
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem 
!! $ ./a.out
!! Segmentation fault (core dumped)
!!
!! Beginning output from valgrind: 
!! ==24369== Conditional jump or move depends on uninitialised value(s)
!! ==24369==    at 0x52967B1: pgf90_get_object_size (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x529805A: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x5296EE6: pgf90_poly_asn (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x40102D: MAIN_ (pgi-20180505a.f90:10)
!! ==24369==    by 0x400D93: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==24369== 
!! ==24369== Use of uninitialised value of size 8
!! ==24369==    at 0x52967BB: pgf90_get_object_size (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x529805A: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x5296EE6: pgf90_poly_asn (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x40102D: MAIN_ (pgi-20180505a.f90:10)
!! ==24369==    by 0x400D93: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==24369== 
!! ==24369== Conditional jump or move depends on uninitialised value(s)
!! ==24369==    at 0x52967B1: pgf90_get_object_size (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x5222C86: pgf90_ptr_src_alloc03 (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x52980AC: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x5296EE6: pgf90_poly_asn (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x40102D: MAIN_ (pgi-20180505a.f90:10)
!! ==24369==    by 0x400D93: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)
!! ==24369== 
!! ==24369== Use of uninitialised value of size 8
!! ==24369==    at 0x52967BB: pgf90_get_object_size (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x5222C86: pgf90_ptr_src_alloc03 (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x52980AC: sourced_alloc_and_assign (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x5296EE6: pgf90_poly_asn (in /opt/pgi/linux86-64/18.4/lib/libpgf90.so)
!! ==24369==    by 0x40102D: MAIN_ (pgi-20180505a.f90:10)
!! ==24369==    by 0x400D93: main (in /home/nnc/Fortran/fortran-compiler-tests/pgi-bugs/a.out)

type, abstract :: json_value
end type
  
type, extends(json_value) :: json_string
  character(:), allocatable :: value
end type

class(json_value), allocatable :: a

allocate(a, source=json_string('foo'))  ! SEGFAULT HERE
select type (a)
type is (json_string)
  if (.not.allocated(a%value)) stop 21
  if (a%value /= 'foo') stop 22
class default
  stop 20
end select

end
