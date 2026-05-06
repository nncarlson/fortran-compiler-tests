!https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125198
!!
!! WRONG CODE WITH -fcheck=bounds
!!
!! This is a gfortran 16 regression.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 16.1.0
!! $ gfortran -g -fcheck=bounds gfortran-20260505.f90 
!! $ ./a.out
!!    0.00000000    
!! At line 34 of file gfortran-20260505.f90
!! Fortran runtime error: Index '1' of dimension 2 of array 'this%normal' outside of expected range (140730496801597:140730496801633)
!! 
!! Error termination. Backtrace:
!! #0  0x401cfa in __unstr_mesh_type_MOD_compute_geometry
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20260505.f90:34
!! #1  0x4022fc in MAIN__
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20260505.f90:41
!! #2  0x402333 in main
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20260505.f90:38
!!

module unstr_mesh_type
  type unstr_mesh
    real, allocatable :: normal(:,:)
  contains
    procedure :: compute_geometry
  end type
contains
  subroutine compute_geometry(this)
    class(unstr_mesh), intent(inout) :: this
    print *, this%normal(1,1) ! THIS IS OKAY
    print *, this%normal(:,1) ! SPURIOUS BOUNDS ERROR HERE
  end subroutine
end module

use unstr_mesh_type
type(unstr_mesh) :: mesh
allocate(mesh%normal(3,10), source=0.0)
call mesh%compute_geometry
end
