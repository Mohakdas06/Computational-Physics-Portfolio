!===========================================================
! File    : prob03_lorenz_butterfly.f90
! Author  : Mohak Das
! Course  : Computational Lab: Classical Mechanics
! Topic   : Phase portrait of Lorenz Attractor
! Method  : RK5
!===========================================================


module prob03_lorenz_butterfly_physics
    use constants_mod
    implicit none
    real(dp), parameter :: sigma = 10.0_dp
    real(dp), parameter :: rho = 28.0_dp
    real(dp), parameter :: beta = 8.0_dp/3.0_dp
    integer, parameter :: n_steps = 100000
    real(dp) :: t0 = 0.0_dp
    real(dp) :: y0(3)
    real(dp) :: t_max = 100.0_dp
    real(dp) :: t_eval(n_steps), sol(size(y0), n_steps)
    real(dp) :: x_val(2), y_val(2), z_val(2)

contains

    function lorenz_deriv(t_val, state) result(dydt)
        real(dp), intent(in) :: t_val
        real(dp), dimension(:), intent(in) :: state
        real(dp),dimension(size(state)) :: dydt
        
        dydt(1) = sigma*(state(2) - state(1))
        dydt(2) = state(1) * (rho - state(3)) - state(2)
        dydt(3) = state(1) * state(2) - beta * state(3)
    end function lorenz_deriv
end module prob03_lorenz_butterfly_physics


program prob03_lorenz_butterfly_driver
    use prob03_lorenz_butterfly_physics
    use RK5_solver
    implicit none
    integer :: i, k

    x_val = [1.0_dp, 30.0_dp]
    y_val = [2.0_dp, -40.0_dp]
    z_val = [-4.0_dp, 10.0_dp]

    open(unit=10, file="data/prob03_lorenz_butterfly.dat", status="replace")
    do i = 1, size(x_val)
        y0 = [x_val(i), y_val(i), z_val(i)]
        call integrate_RK5(lorenz_deriv, t0, y0, t_max, n_steps, t_eval, sol)

        do k = 1, n_steps
            write(10, *) t_eval(k), sol(1, k), sol(2, k), sol(3, k)
        end do
        write(10, *) ""
        write(10, *) ""
    end do
    close(10)
    write(*, '(A)') "Phase portrait data written in prob03_lorenz_butterfly.dat."
end program prob03_lorenz_butterfly_driver