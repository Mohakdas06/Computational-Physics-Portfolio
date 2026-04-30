module constants_mod
    implicit none
    integer, parameter :: dp = selected_real_kind(15, 307)
    real(dp), parameter :: h_bar = 1.0_dp
    real(dp), parameter :: mass = 1.0_dp
    real(dp), parameter :: pi = 3.1415926535897932384626433832795_dp
contains
end module constants_mod