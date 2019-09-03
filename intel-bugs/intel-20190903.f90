!! Service Request Number: 04330341
!!
!! INTERNAL COMPILER ERROR
!!
!! This is a regression in version 19. Works fine in versions 17 and 18.
!!
!! $ ifort --version
!! ifort (IFORT) 19.0.4.243 20190416
!! Copyright (C) 1985-2019 Intel Corporation.  All rights reserved.
!! 
!! $ ifort -c intel-20190903.f90 
!! intel-20190903.f90(22): internal error: Please visit 'http://www.intel.com/software/products/support' for assistance.
!! end module

module fhypre
  use,intrinsic :: iso_c_binding, only: hypre_associated => c_associated
  private
  public :: hypre_associated
end module

module hypre_hybrid_type
  use fhypre
end module

