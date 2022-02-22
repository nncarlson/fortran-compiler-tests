!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104630
!!
!! MODULE SUBROUTINE NOT ACCESSIBLE FROM SUBMODULE
!!
!! Host procedures should be accessible from submodules of the host.
!! If the three program units are combined in a single file there is no error.
!!
!! $ gfortran gfortran-20220221-{module,submodule,main}.f90
!! /usr/bin/ld: /tmp/ccrtpWxQ.o: in function `__moda_MOD_foo':
!! gfortran-20220221-submodule.f90:(.text+0x17): undefined reference to `__moda_MOD_bar'
!! collect2: error: ld returned 1 exit status

module modA
  private
  type, public :: typeA
  contains
    procedure :: foo
  end type
  interface
    module subroutine foo(this)
      class(typeA) :: this
    end subroutine
  end interface
contains
  subroutine bar(this)
    type(typeA) :: this
  end subroutine
end module
