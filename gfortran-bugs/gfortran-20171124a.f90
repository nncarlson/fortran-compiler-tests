!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83146
!! Fixed in 8.1.1 (20180521)
!!
!! ICE on select case statement with associate name
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.0 20171123 (experimental)
!! 
!! $ gfortran -c gfortran-20171124.f90 
!! gfortran-20171124.f90:9:0:
!! 
!!    select case (n_array(1))
!!  
!! internal compiler error: in gfc_get_element_type, at fortran/trans-types.c:1231
!! 0x5a5da8 gfc_get_element_type(tree_node*)
!! 	../../gcc/fortran/trans-types.c:1231
!! 0x95d247 trans_associate_var
!! 	../../gcc/fortran/trans-stmt.c:1632
!! 0x95d247 gfc_trans_block_construct(gfc_code*)
!! 	../../gcc/fortran/trans-stmt.c:1890
!! 0x8e48c7 trans_code
!! 	../../gcc/fortran/trans.c:1924
!! 0x90e7a8 gfc_generate_function_code(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.c:6437
!! 0x89d036 translate_all_program_units
!! 	../../gcc/fortran/parse.c:6091
!! 0x89d036 gfc_parse_file()
!! 	../../gcc/fortran/parse.c:6294
!! 0x8e0eaf gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.c:204
!!

type foo
  integer n
end type
type bar
  type(foo) array(2)
end type
type(bar) b
associate (n_array => b%array%n)
  select case (n_array(1))
  case default
  end select
end associate
end

!! Turns out the associate block can be empty. This gives an ICE too
!type foo
!  integer n
!end type
!type bar
!  type(foo) array(2)
!end type
!type(bar) b
!associate (n_array => b%array%n)
!end associate
!end
