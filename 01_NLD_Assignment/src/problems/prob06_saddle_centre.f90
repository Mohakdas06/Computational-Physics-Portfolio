!====================================================================
! File    : prob06_saddle_centre.f90
! Author  : Mohak Das
! Course  : Computational Lab: Classical Mechanics
! Topic   : Pure non linear system with one saddle and one centre
! Method  : RK5
!====================================================================


module prob06_saddle_centre_physics
    use constants_mod
    implicit none
    integer, parameter :: n_steps = 3000
    real(dp) :: t0 = 0.0_dp
    real(dp) :: y0(2)
    real(dp) :: t_max = 30.0_dp
    real(dp) :: t_eval(n_steps), sol(size(y0), n_steps)
    real(dp) :: x_val(15)
    real(dp) :: y_val(15)

contains

    function lv_sad_cen_deriv(t_val, state) result(dydt)
        real(dp), intent(in) :: t_val
        real(dp), dimension(:), intent(in) :: state
        real(dp),dimension(size(state)) :: dydt
        
        dydt(1) = state(1) + state(2) - state(2)**2
        dydt(2) = state(1) - state(2)
    end function lv_sad_cen_deriv
end module prob06_saddle_centre_physics


program prob06_saddle_centre_driver
    use prob06_saddle_centre_physics
    use RK5_solver
    implicit none
    integer :: i, k

    x_val = [2.2_dp, 2.5_dp, 2.8_dp, 3.2_dp, 0.5_dp, &
             0.1_dp, 0.1_dp, 0.5_dp, -0.5_dp, 1.0_dp, &
             -1.0_dp, 0.05_dp, 0.1_dp, -2.0_dp, 1.5_dp]

    y_val = [2.0_dp, 2.0_dp, 2.0_dp, 2.0_dp, 0.0_dp, &
             0.5_dp, -0.5_dp, -1.0_dp, 1.0_dp, -1.5_dp, &
             1.5_dp, 0.1_dp, -0.1_dp, 2.0_dp, -2.0_dp]

    open(unit=10, file="data/prob06_saddle_centre.dat", status="replace")
    do i = 1, size(x_val)
        y0 = [x_val(i), y_val(i)]
        call integrate_RK5(lv_sad_cen_deriv, t0, y0, t_max, n_steps, t_eval, sol)

        do k = 1, n_steps
            if ( abs(sol(1,k)) > 10.0_dp .or. abs(sol(2,k)) > 10.0_dp ) exit
            write(10, *) t_eval(k), sol(1, k), sol(2, k)
        end do
        write(10, *) ""
    end do
    close(10)
    write(*, '(A)') "Phase portrait data written in prob06_saddle_centre.dat."
end program prob06_saddle_centre_driver