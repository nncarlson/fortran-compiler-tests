!! Reported to OpenCoarrays: https://github.com/sourceryinstitute/OpenCoarrays/issues/748
!!
!! SPURIOUS COARRAY OUT-OF-BOUNDS ERROR WITH -fcheck=bounds
!!
!! $ caf --version
!! OpenCoarrays Coarray Fortran Compiler Wrapper (caf version 2.9.2-13-g235167d)
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 11.2.0
!!
!! $ caf -fcheck=bounds gfortran-20220127.f90 
!! $ cafrun -n 4 ./a.out
!!
!! At line 69 of file gfortran-20220127.f90
!! Fortran runtime error: Index '15' of dimension 1 of array 'buffer%array' above upper bound of 14

program main

  type :: index_map
    integer, allocatable :: offP_index(:)
    integer, allocatable :: recv_displs(:), recv_counts(:)
    integer, allocatable :: send_displs(:), send_image(:), send_index(:)
    integer, allocatable :: send_index_ref(:)
  end type
  type(index_map) :: imap

  select case (this_image())
  case (1)
    imap%send_image  = [2, 3, 4]
    imap%recv_counts = [3, 5, 4]
    imap%recv_displs = [0, 3, 8]
    imap%send_displs = [0, 0, 0]
    imap%offP_index = [8, 10, 12, 13, 14, 16, 18, 19, 21, 23, 25, 27]
    imap%send_index_ref = [1, 2, 3, 4, 5, 6, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6]
  case (2)
    imap%send_image  = [1, 3, 4]
    imap%recv_counts = [6, 2, 4]
    imap%recv_displs = [0, 6, 8]
    imap%send_displs = [0, 5, 4]
    imap%offP_index = [1, 2, 3, 4, 5, 6, 15, 16, 20, 21, 24, 25]
    imap%send_index_ref = [8, 10, 12, 9, 10, 11, 12, 7, 8, 9, 10, 11, 12]
  case (3)
    imap%send_image  = [1, 2, 4]
    imap%recv_counts = [5, 4, 6]
    imap%recv_displs = [0, 5, 9]
    imap%send_displs = [6, 3, 8]
    imap%offP_index = [2, 3, 4, 5, 6, 9, 10, 11, 12, 21, 23, 24, 25, 26, 27]
    imap%send_index_ref = [13, 14, 16, 18, 19, 15, 16, 13, 14, 15, 16, 17, 18, 19]
  case (4)
    imap%send_image  = [1, 2, 3]
    imap%recv_counts = [6, 6, 7]
    imap%recv_displs = [0, 6, 12]
    imap%send_displs = [11, 7, 7]
    imap%offP_index = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
    imap%send_index_ref = [21, 23, 25, 27, 20, 21, 24, 25, 21, 23, 24, 25, 26, 27]
  end select
  allocate(imap%send_index, mold=imap%send_index_ref)
  imap%send_index = 0

  call sub(imap)

  if (any(imap%send_index /= imap%send_index_ref)) error stop

contains

  subroutine sub(this)

    type(index_map), intent(inout), target :: this

    integer :: j, k
    type :: box
      integer, pointer :: array(:)
    end type
    type(box), allocatable :: buffer[:]
  
    allocate(buffer[*])
    buffer%array => this%send_index
    sync all
    do j = 1, size(this%recv_counts)
      associate (i => this%send_image(j), n => this%recv_counts(j), &
                 s0 => this%send_displs(j), r0 => this%recv_displs(j))
        do k = 1, n
          !write(*,'(i0,a,5(1x,i0))') this_image(), ': ', j, i, &
          !    lbound(buffer[i]%array), s0+k, ubound(buffer[i]%array)
          buffer[i]%array(s0+k) = this%offP_index(r0+k)
        end do
      end associate
    end do
    sync all
  end subroutine

end program
