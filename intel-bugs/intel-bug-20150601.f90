!!
!! ASSIGNMENT TO ALLOCATABLE ARRAY YIELDS BAD ARRAY
!!
!! The following example makes an assignment to an allocatable array.
!! The array appears good, but when passed to a subroutine it is bad.
!! A key ingredient seems to be that the rhs expression of the assignment
!! is a reference to an elemental type bound function.
!!
!! % ifort --version
!! ifort (IFORT) 15.0.2 20150121
!! 
!! % ifort -assume realloc_lhs intel-bug-20150601.f90 
!! % ./a.out
!!            1           2           3           4           5   <== BEFORE CALL (GOOD)
!!            1           5           0           0           0   <== AFTER CALL (BAD)
!!

module set_type

  type :: set
    type(set), pointer :: foo
    integer :: n
  contains
    procedure :: size => set_size
  end type

contains

  elemental integer function set_size (this)
    class(set), intent(in) :: this
    set_size = this%n
  end function

end module

program main

  use set_type
  integer, allocatable :: sizes(:)
  type(set), allocatable :: sets(:)
  
  allocate(sets(5))
  sets%n = [1, 2, 3, 4, 5]  ! YIELDS BAD ARRAY WHEN PASSED
  
  sizes = sets%size() ! AUTOMATIC ALLOCATION YIELDS BAD ARRAY WHEN PASSED
  
  ! BUT THIS WORKS
  !allocate(sizes(5))
  !sizes(:) = sets%size()

  print *, sizes      ! PRINTS EXPECTED VALUES
  call sub (sizes)    ! PASS TO SUBROUTINE TO PRINT

contains

  subroutine sub (array)
    integer :: array(:)
    print *, array    ! PRINTS GARBAGE
  end subroutine

end program
  
