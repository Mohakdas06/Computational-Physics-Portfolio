module constants_mod
    implicit none
    integer, parameter :: dp = selected_real_kind(15, 307)
    real(dp), parameter :: pi = acos(-1.0_dp)
    real(dp), parameter :: g = 9.81_dp

contains
end module constants_mod