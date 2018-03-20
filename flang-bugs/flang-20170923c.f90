!! https://github.com/flang-compiler/flang/issues/240
!! Fixed as of 3/19/2018.
!!
!! $ flang -c flang-bug-20170923c.f90
!! clang-5.0: error: unable to execute command: Segmentation fault (core dumped)
!! clang-5.0: error: Fortran frontend to LLVM command failed due to signal (use -v to see invocation)
!! clang version 5.0.1 (https://github.com/flang-compiler/clang.git b11539abc46cbd19189c5719d1e30539de3a93b9) (https://github.com/llvm-mirror/llvm.git 81029f142231bde8e119becda112a2173f1459c9)
!! Target: x86_64-unknown-linux-gnu
!! Thread model: posix
!! InstalledDir: /opt/flang/5.0/bin
!! clang-5.0: note: diagnostic msg: PLEASE submit a bug report to  and include the crash backtrace, preprocessed source, and associated run script.
!! clang-5.0: note: diagnostic msg: Error generating preprocessed source(s) - no preprocessable inputs.


module map_type
  type :: item
    type(item), pointer :: next => null()
  end type
  type :: map
    type(item), pointer :: first => null()
  end type
  type :: parameter_list
    type(map) :: params = map() ! this default initializaton causes the ICE
  end type
end module
