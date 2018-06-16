!! https://github.com/flang-compiler/flang/issues/240
!! This adds a final procedure for ITEM to flang-20180319a.f90
!!
!! This example now compiles with 543785e7 (20180615), however
!! the parent example flang-20180319a.f90 still dies with an ICE.
!!
!! This is with the 3/19/2018 flang version.
!!
!! $ flang -c flang-20180319b.f90
!! F90-F-0155-Empty structure constructor() - type map (flang-20180319b.f90: 20)
!! F90/x86-64 Linux Flang - 1.5 2017-05-01: compilation aborted

module map_type
  type :: item
    type(item), pointer :: next => null(), prev => null()
  contains
    final :: item_delete
  end type
  type :: map
    type(item), pointer :: first => null()
  end type
  type :: parameter_list
    type(map) :: params = map() ! valid empty constructor rejected by flang
  end type
contains
  subroutine item_delete(this)
    type(item), intent(inout) :: this
  end subroutine
end module
