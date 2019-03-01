!!
!! Update: Now working in 16.1.1.2
!!
!! This example should procdue this output
!!
!!   any_scalar constructor
!!   any_scalar constructor
!!   returning stat= 1
!!
!! (the stat=1 is correct!) and exit with a 0 status code. But it will
!! often -- but not always! -- produce a segfault after the output. Notice
!! that the traceback shows the ANY_VECTOR constructor. That code should
!! never be called in this example! Using version 16.1.1 RC3 on power9.
!!
!! $ xlf2008 -g ibm-20181201.f90 
!! ** map_any_type   === End of Compilation 1 ===
!! ** parameter_entry_class   === End of Compilation 2 ===
!! ** parameter_list_type   === End of Compilation 3 ===
!! ** main   === End of Compilation 4 ===
!! 1501-510  Compilation successful for file ibm-20181201.f90.
!! !! often -- but not always -- segfault after producing the output. with
!! !! this traceback
!!
!! $ ./a.out
!!  any_scalar constructor
!!  any_scalar constructor
!!  returning stat= 1
!! 
!!   Signal received: SIGSEGV - Segmentation violation
!! 
!!   Traceback:
!!     Offset 0x000000c0 in procedure _xlfN10any_vectorD1scalar, near line 87 in
!! file ibm-20181201.f90
!!     Location 0x000020000018b57c
!!     Offset 0x00000088 in procedure
!! __parameter_entry_class_NMOD__xlfN10any_vectorD1, near line 81 in file
!! ibm-20181201.f90
!!     Offset 0x000007b8 in procedure __parameter_list_type_NMOD_set_vector, near
!! line 128 in file ibm-20181201.f90
!!     Offset 0x000001d4 in procedure test_basic, near line 149 in file
!! ibm-20181201.f90
!!     Offset 0x00000028 in procedure main, near line 143 in file ibm-20181201.f90
!!     Location 0x0000200000c950fc
!!     Location 0x0000200000c952f0
!!     --- End of call chain ---


module map_any_type
  type :: map_any
  contains
    procedure :: insert
  end type
contains
  subroutine insert (this, key, value)
    class(map_any), intent(inout) :: this
    character(*), intent(in) :: key
    class(*), intent(in) :: value
  end subroutine
end module


module parameter_entry_class
  type, abstract :: parameter_entry
  end type
  type, extends(parameter_entry) :: any_scalar
    class(*), allocatable :: value
  end type
  interface any_scalar
    procedure any_scalar_value
  end interface
  type, extends(parameter_entry) :: any_vector
    class(*), allocatable :: value(:)
  end type
  interface any_vector
    procedure any_vector_value
  end interface
contains
  function any_scalar_value(value) result(obj)
    class(*), intent(in) :: value
    type(any_scalar) :: obj
    print *, 'any_scalar constructor'
    allocate(obj%value, source=value)
  end function
  function any_vector_value(value) result(obj)
    class(*), intent(in) :: value(:)
    type(any_vector) :: obj
    print *, 'any_vector constructor'
    allocate(obj%value, source=value)
  end function
end module


module parameter_list_type
  use parameter_entry_class
  use map_any_type
  type :: parameter_list
    type(map_any) :: params = map_any()
  contains
    generic :: set => set_scalar, set_vector
    procedure, private :: set_scalar
    procedure, private :: set_vector
  end type
contains

  subroutine set_scalar(this, name, value)
    class(parameter_list), intent(inout) :: this
    character(*), intent(in) :: name
    class(*), intent(in) :: value
    call this%params%insert(name, any_scalar(value))
  end subroutine

  subroutine set_vector (this, name, value, stat)
    class(parameter_list), intent(inout) :: this
    character(*), intent(in) :: name
    class(*), intent(in) :: value(:)
    integer, intent(out) :: stat
    class(parameter_entry), pointer :: pentry
    stat = 0
    pentry => find_entry(this%params, name)
    if (associated(pentry)) then
      select type (pentry)
      type is (any_vector)
      class default ! THIS BRANCH IS EXECUTED
        stat = 1
        print *, 'returning stat=', stat
      end select
    else ! THIS BRANCH NOT EXECUTED
      print *, 'in wrong branch'
      call this%params%insert(name, any_vector(value))
    end if
  end subroutine

  function find_entry(map, name) result(pentry)
    class(map_any), intent(in) :: map
    character(*), intent(in) :: name
    class(parameter_entry), pointer :: pentry
    allocate(pentry, source=any_scalar(42))
  end function find_entry

end module


program main
  use parameter_list_type
  call test_basic
contains
  subroutine test_basic
    type(parameter_list) :: p
    integer ::stat
    call p%set('foo', 1)
    call p%set('foo', [1,2], stat)
    if (stat == 0) stop 1
  end subroutine
end program
