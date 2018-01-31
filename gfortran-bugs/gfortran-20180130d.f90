!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84122
!!
!! REJECTS VALID STATEMENT SEQUENCE IN PDT DEFINITION
!!
!! The PRIVATE statement comes after any type parameter declarations;
!! see R425 (F08). GFortran 8.0 rejects this valid example. It regards the
!! type parameters as regular components (they are not), and so wants the
!! PRIVATE statement before them. 
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.0 20171227 (experimental)
!! $ gfortran gfortran-20180130d.f90 
!! gfortran-20180130d.f90:22:9:
!!
!!    private
!!          1
!! Error: PRIVATE statement at (1) must precede structure components

module mod
type foo(dim)
  integer,len :: dim
  private
  integer :: array(dim)
end type
end module
