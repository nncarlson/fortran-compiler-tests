!!
!! ASSIGNMENT TO ALLOCATABLE ARRAY NOT WORKING
!!
!! The following example fails with a runtime error when making an
!! assignment to an allocatable lhs array.  This is standard conforming
!! and should work, and it does work for non-polymorphic rhs vectors,
!! but something is going wrong in this type-is stanza.
!!
!! Note: must use -assume realloc_lhs (or -standard-semantics) to get
!! standard-conforming behavior.
!!
!! % ifort --version
!! ifort (IFORT) 14.0.2 20140120
!! 
!! % ifort -assume realloc_lhs intel-bug-20140424.f90
!! % ./a.out
!! preparing to assign [1,2] to allocatable lhs array
!! forrtl: severe (174): SIGSEGV, segmentation fault occurred
!! Image              PC                Routine            Line        Source             
!! a.out              0000000000473C59  Unknown               Unknown  Unknown
!! a.out              000000000047252E  Unknown               Unknown  Unknown
!! a.out              0000000000427C92  Unknown               Unknown  Unknown
!! a.out              00000000004077E3  Unknown               Unknown  Unknown
!! a.out              000000000040C39B  Unknown               Unknown  Unknown
!! libpthread.so.0    0000003FA980F750  Unknown               Unknown  Unknown
!! a.out              00000000004031EF  Unknown               Unknown  Unknown
!! a.out              0000000000402C96  Unknown               Unknown  Unknown
!! libc.so.6          0000003FA8C21D65  Unknown               Unknown  Unknown
!! a.out              0000000000402B89  Unknown               Unknown  Unknown
!!

module any_vector_type

  type :: any_vector
    class(*), allocatable :: value(:)
  contains
    procedure :: get_int_value
  end type

contains

  subroutine get_int_value (this, value)
    class(any_vector), intent(in) :: this
    integer, allocatable :: value(:)
    select type (v => this%value)
    type is (integer)
      print '(a,i0,",",i0,a)', 'preparing to assign [', v, '] to allocatable lhs array'
      value = v ! SHOULD ALLOCATE THE LHS IF NEEDED BEFORE ASSIGNING
      print *, 'successful'
    end select
  end subroutine

end module

program main

  use any_vector_type
  
  type(any_vector) :: a
  integer, allocatable :: x(:)
  
  allocate(a%value(2), source=[1,2])
  call a%get_int_value (x)
  
end program
