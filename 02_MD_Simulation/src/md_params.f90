module md_params
    implicit none
    integer, parameter :: dp = selected_real_kind(15, 307)

    integer :: Nmol, Nstep
    real(dp) :: dt, Lx, Ly

    real(dp), allocatable :: x(:), y(:)
    real(dp), allocatable :: vx(:), vy(:)
    real(dp), allocatable :: Fx(:), Fy(:)
    real(dp), allocatable :: Fx1(:), Fy1(:)
contains
    
end module md_params