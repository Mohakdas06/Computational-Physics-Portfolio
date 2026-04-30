!====================================================================
! File    : prob02_rabbit_sheep_model.f90
! Author  : Mohak Das
! Course  : Computational Lab: Classical Mechanics
! Topic   : Lotka-Volterra Competition Model (Rabbit and Sheep Model)
! Method  : RK5
!====================================================================


module prob02_rabbit_sheep_physics
    use constants_mod
    implicit none
    integer, parameter :: n_steps = 1000
    real(dp) :: t0 = 0.0_dp
    real(dp) :: y0(2)
    real(dp) :: t_max = 10.0_dp
    real(dp) :: t_eval(n_steps), sol(size(y0), n_steps)
    real(dp) :: rabbit_val(15)
    real(dp) :: sheep_val(15)

contains

    function lv_comp_deriv(t_val, state) result(dydt)
        real(dp), intent(in) :: t_val
        real(dp), dimension(:), intent(in) :: state
        real(dp),dimension(size(state)) :: dydt
        
        dydt(1) = state(1) * (3 - state(1) - 2*state(2))
        dydt(2) = state(2) * (2 - state(1) - state(2))
    end function lv_comp_deriv
end module prob02_rabbit_sheep_physics


program prob02_rabbit_sheep_driver
    use prob02_rabbit_sheep_physics
    use RK5_solver
    implicit none
    integer :: i, k

    rabbit_val = [2.0_dp, 3.0_dp, 0.1_dp, 3.0_dp, 3.0_dp, 0.02_dp, 0.1_dp, &
        0.09_dp, 1.5_dp, 0.06_dp, 0.125_dp, 0.025_dp, 3.0_dp, 3.0_dp, 0.5_dp]

    sheep_val = [3.0_dp, 1.2_dp, 0.1_dp, 2.1_dp, 2.3_dp, 0.1_dp, 0.2_dp, &
        0.2_dp, 3.0_dp, 0.1_dp, 0.07_dp, 0.23_dp, 1.5_dp, 3.0_dp, 3.0_dp]

    open(unit=10, file="data/prob02_rabbit_sheep.dat", status="replace")
    do i = 1, size(rabbit_val)
        y0 = [rabbit_val(i), sheep_val(i)]
        call integrate_RK5(lv_comp_deriv, t0, y0, t_max, n_steps, t_eval, sol)

        do k = 1, n_steps
            write(10, *) t_eval(k), sol(1, k), sol(2, k)
        end do
        write(10, *) ""
    end do
    close(10)
    write(*, '(A)') "Phase portrait data written in prob02_rabbit_sheep."
end program prob02_rabbit_sheep_driver