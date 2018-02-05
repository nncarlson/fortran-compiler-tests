!! BAD INTERMEDIATE C CODE -- LIST-DIRECTED I/O OF PDT
!!
!! The NAG 6.2 compiler generates invalid C code for this example.  It seems
!! to be specific to the character type component; there are no errors if it
!! is replaced by a real array, for example
!! $ nagfor nag-20180204b.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! [NAG Fortran Compiler normal termination]
!! nag-20180204b.f90: In function 'main':
!! nag-20180204b.f90:25:122: error: 'struct _PDT_UNKNOWNLEN_MAINDT_foo' has no member named 'addr'
!!  write(buffer,*) var
!!                                                                                                                           ^
!! nag-20180204b.f90:26:7: error: incompatible types when assigning to type 'struct _PDT_UNKNOWNLEN_MAINDT_foo *' from type '__NAGf90_LPDT_Pointer {aka struct <anonymous>}'
!!  read(buffer,*) var

type foo(nlen)
  integer,len :: nlen
  character(nlen) :: name
end type

character(80) :: buffer
type(foo(:)), allocatable :: var

var = foo(3)('abc')
write(buffer,*) var
read(buffer,*) var

end
