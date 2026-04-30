!====================================================================
! File    : prob04_bacteria_colony.f90
! Author  : Mohak Das
! Course  : Computational Lab: Classical Mechanics
! Topic   : Bacterial Colony Model
! Method  : RK5
!====================================================================


module prob04_bacteria_colony_physics
    use constants_mod
    implicit none
    integer, parameter :: n_steps = 1000
    real(dp) :: t0 = 0.0_dp
    real(dp) :: y0(2)
    real(dp) :: t_max = 10.0_dp
    real(dp) :: t_eval(n_steps), sol(size(y0), n_steps)
    real(dp) :: col1_val(15)
    real(dp) :: col2_val(15)

contains

    function lv_bacteria_deriv(t_val, state) result(dydt)
        real(dp), intent(in) :: t_val
        real(dp), dimension(:), intent(in) :: state
        real(dp),dimension(size(state)) :: dydt
        
        dydt(1) = state(1) * (3 - state(1) - 2*state(2))
        dydt(2) = state(2) * (3 - 2*state(1) - state(2))
    end function lv_bacteria_deriv
end module prob04_bacteria_colony_physics


program prob04_bacteria_colony_driver
    use prob04_bacteria_colony_physics
    use RK5_solver
    implicit none
    integer :: i, k

    col1_val = [0.1_dp, 0.3_dp, 0.2_dp, 1.5_dp, 0.5_dp, 3.0_dp, 2.5_dp, &
                   3.5_dp, 0.8_dp, 0.9_dp, 2.0_dp, 2.1_dp, 1.1_dp, 1.3_dp, 0.1_dp]

    col2_val = [0.3_dp, 0.1_dp, 1.5_dp, 0.2_dp, 3.0_dp, 0.5_dp, 3.5_dp, &
                   2.5_dp, 0.9_dp, 0.8_dp, 2.1_dp, 2.0_dp, 1.3_dp, 1.1_dp, 0.1_dp]

    open(unit=10, file="data/prob04_bacteria_colony.dat", status="replace")
    do i = 1, size(col1_val)
        y0 = [col1_val(i), col2_val(i)]
        call integrate_RK5(lv_bacteria_deriv, t0, y0, t_max, n_steps, t_eval, sol)

        do k = 1, n_steps
            write(10, *) t_eval(k), sol(1, k), sol(2, k)
        end do
        write(10, *) ""
    end do
    close(10)
    write(*, '(A)') "Phase portrait data written in prob04_bacteria_colony.dat."
end program prob04_bacteria_colony_driver