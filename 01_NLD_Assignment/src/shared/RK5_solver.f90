module RK5_solver
    use constants_mod
    implicit none
    
contains
    subroutine RK5(f, t, y, h)
        interface
            function f(t_val, state) result(dydt)
                use constants_mod
                real(dp), intent(in) :: t_val
                real(dp), dimension(:), intent(in) :: state
                real(dp), dimension(size(state)) :: dydt
            end function f
        end interface
        real(dp), intent(in) :: h
        real(dp), intent(inout) :: t
        real(dp), dimension(:), intent(inout) :: y
        real(dp), dimension(size(y)) :: k1, k2, k3, k4, k5, k6

        k1 = f(t, y)
        k2 = f(t + 1.0_dp/4.0_dp * h, y + h * (1.0_dp/4.0_dp * k1))
        k3 = f(t + 1.0_dp/4.0_dp * h, y + h * (1.0_dp/8.0_dp * k1 + 1.0_dp/8.0_dp * k2))
        k4 = f(t + 1.0_dp/2.0_dp * h, y + h * (1.0_dp/2.0_dp * k3))
        k5 = f(t + 3.0_dp/4.0_dp * h, y + h * (3.0_dp/16.0_dp * k1 &
        - 3.0_dp/8.0_dp * k2 + 3.0_dp/8.0_dp * k3 + 9.0_dp/16.0_dp * k4))
        k6 = f(t + h, y + h * (-3.0_dp/7.0_dp * k1 + 8.0_dp/7.0_dp * k2 &
        + 6.0_dp/7.0_dp * k3 - 12.0_dp/7.0_dp * k4 + 8.0_dp/7.0_dp * k5))
        
        y = y + h * (7.0_dp/90.0_dp * k1 + 32.0_dp/90.0_dp * k3 + 12.0_dp/90.0_dp * k4 &
        + 32.0_dp/90.0_dp * k5 + 7.0_dp/90.0_dp * k6)
        t = t + h
    end subroutine RK5

    subroutine integrate_RK5(f, t0, y0, t_max, n_steps, t_eval, sol)
        interface
            function f(t_val, state) result(dydt)
                use constants_mod
                real(dp), intent(in) :: t_val
                real(dp), dimension(:), intent(in) :: state
                real(dp), dimension(size(state)) :: dydt
            end function f
        end interface
        real(dp), intent(in) :: t0, t_max
        real(dp), dimension(:), intent(in) :: y0
        integer, intent(in) :: n_steps
        real(dp), intent(out) :: t_eval(n_steps), sol(size(y0), n_steps)

        integer :: i
        real(dp) :: t, h
        real(dp), dimension(size(y0)) :: y

        h = (t_max - t0)/real(n_steps, dp)
        
        t_eval = 0.0_dp
        sol = 0.0_dp

        t = t0
        y = y0

        t_eval(1) = t
        sol(:, 1) = y

        do i = 2, n_steps
            call RK5(f, t, y, h)
            t_eval(i) = t
            sol(:, i) = y
        end do

    end subroutine integrate_RK5
end module RK5_solver