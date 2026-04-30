!====================================================================
! File    : prob05_pure_quartic.f90
! Author  : Mohak Das
! Course  : Computational Lab: Classical Mechanics
! Topic   : Pure Quartic Oscillator
! Method  : RK5
!====================================================================


module prob05_pure_quartic_physics
    use constants_mod
    implicit none
    integer, parameter :: n_steps = 5000
    real(dp) :: t0 = 0.0_dp
    real(dp) :: y0(2)
    real(dp) :: t_max = 50.0_dp
    real(dp) :: t_eval(n_steps), sol(size(y0), n_steps)
    real(dp) :: x_val(15)
    real(dp) :: y_val(15)

contains

    function lv_quartic_deriv(t_val, state) result(dydt)
        real(dp), intent(in) :: t_val
        real(dp), dimension(:), intent(in) :: state
        real(dp),dimension(size(state)) :: dydt
        
        dydt(1) = state(2)
        dydt(2) = - (state(1)**3)
    end function lv_quartic_deriv
end module prob05_pure_quartic_physics


program prob05_pure_quartic_driver
    use prob05_pure_quartic_physics
    use RK5_solver
    implicit none
    integer :: i, k

    x_val = [0.2_dp, 0.4_dp, 0.6_dp, 0.8_dp, 1.0_dp, 1.2_dp, 1.4_dp, &
             1.6_dp, 1.8_dp, 2.0_dp, 2.2_dp, 2.4_dp, 2.6_dp, 2.8_dp, 3.0_dp]

    y_val = [0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, &
             0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp]

    open(unit=10, file="data/prob05_pure_quartic.dat", status="replace")
    do i = 1, size(x_val)
        y0 = [x_val(i), y_val(i)]
        call integrate_RK5(lv_quartic_deriv, t0, y0, t_max, n_steps, t_eval, sol)

        do k = 1, n_steps
            write(10, *) t_eval(k), sol(1, k), sol(2, k)
        end do
        write(10, *) ""
    end do
    close(10)
    write(*, '(A)') "Phase portrait data written in prob05_pure_quartic.dat."
end program prob05_pure_quartic_driver