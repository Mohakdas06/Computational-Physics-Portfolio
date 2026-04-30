!===========================================================
! File    : prob01_simple_pendulum.f90
! Author  : Mohak Das
! Course  : Computational Lab: Classical Mechanics
! Topic   : Phase portrait of Simple Pendulum
! Method  : RK5
!===========================================================


module prob01_simple_pendulum_physics
    use constants_mod
    implicit none
    real(dp), parameter :: L = 1.0_dp
    integer, parameter :: n_steps = 1000
    real(dp) :: t0 = 0.0_dp
    real(dp) :: y0(2)
    real(dp) :: t_max = 10.0_dp
    real(dp) :: t_eval(n_steps), sol(size(y0), n_steps)
    real(dp) :: theta_val(9)
    real(dp) :: omega_val(9)

contains

    function pendulum_deriv(t_val, state) result(dydt)
        real(dp), intent(in) :: t_val
        real(dp), dimension(:), intent(in) :: state
        real(dp),dimension(size(state)) :: dydt
        
        dydt(1) = state(2)
        dydt(2) = -(g/L) * sin(state(1))
    end function pendulum_deriv
end module prob01_simple_pendulum_physics


program prob01_simple_pendulum_driver
    use prob01_simple_pendulum_physics
    use RK5_solver
    implicit none
    integer :: i, j, k

    theta_val = [-2.0_dp*pi, -1.5_dp*pi, -pi, -0.5_dp*pi, 0.0_dp, 0.5_dp*pi, pi, 1.5_dp*pi, 2.0_dp*pi]

    omega_val = [-2.0_dp*pi, -1.5_dp*pi, -pi, -0.5_dp*pi, 0.0_dp, 0.5_dp*pi, pi, 1.5_dp*pi, 2.0_dp*pi]

    open(unit=10, file="data/prob01_pendulum.dat", status="replace")
    do i = 1, size(theta_val)
        do j = 1, size(omega_val)
            y0 = [theta_val(i), omega_val(j)]
            call integrate_RK5(pendulum_deriv, t0, y0, t_max, n_steps, t_eval, sol)

            do k = 1, n_steps
                write(10, *) t_eval(k), sol(1, k), sol(2, k)
            end do
            write(10, *) ""
        end do
    end do
    close(10)
    write(*, '(A)') "Phase portrait data written in prob01_pendulum.dat."
end program prob01_simple_pendulum_driver