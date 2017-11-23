!! https://github.com/flang-compiler/flang/issues/312
!!
!! $ flang flang-20171122h.f90 
!! F90-S-0000-Internal compiler error. charlen: sym not adjustable-length char     299  (flang-20171122h.f90: 1)
!! F90-S-0000-Internal compiler error. charlen: sym not adjustable-length char     299  (flang-20171122h.f90: 1)
!!   0 inform,   0 warnings,   2 severes, 0 fatal for MAIN

print '(2a)', elem_raise_case(['a','z']) ! expect XX
contains
  elemental function elem_raise_case(s) result(ucs)
    character(*), intent(in) :: s
    character(len(s)) :: ucs
    ucs = repeat('X',len(s)) ! ignore S and just assign fixed string
  end function
end program
