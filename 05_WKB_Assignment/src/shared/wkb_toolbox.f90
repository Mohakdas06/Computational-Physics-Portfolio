module wkb_toolbox
    use constants_mod
    implicit none

    abstract interface
        subroutine turn_point_func(E, x_L, x_R)
            use constants_mod
            real(dp), intent(in)  :: E
            real(dp), intent(out) :: x_L, x_R
        end subroutine turn_point_func
    end interface
contains

    ! ------------------------------------------------------------------
    ! Generic Integrator: Calculates Integral p(x) dx
    ! ------------------------------------------------------------------
    function wkb_integral(E, V, x_in_L, x_in_R) result(action)
        real(dp), external :: V
        real(dp), intent(in) :: E
        real(dp), intent(in) :: x_in_L, x_in_R
        real(dp) :: action

        real(dp) :: x_left, x_right, x, dx, p_x
        integer :: i
        integer, parameter :: N_STEPS_DEFAULT = 2000

        x_left = x_in_L
        x_right = x_in_R
        
        ! Integrate (Trapezoidal Rule to preserve accuracy at the turning points)
        dx = (x_right - x_left) / real(N_STEPS_DEFAULT, dp)
        action = 0.0_dp
        
        x = x_left
        if (E > V(x)) then
            p_x = sqrt(2.0_dp * mass * (E - V(x)))
            action = action + 0.5_dp * p_x
        end if
        
        do i = 1, N_STEPS_DEFAULT - 1
            x = x_left + i * dx
            if (E > V(x)) then
                p_x = sqrt(2.0_dp * mass * (E - V(x)))
                action = action + p_x
            end if
        end do

        x = x_right
        if (E > V(x)) then
            p_x = sqrt(2.0_dp * mass * (E - V(x)))
            action = action + 0.5_dp * p_x
        end if

        action = action * dx
    end function wkb_integral


    ! ------------------------------------------------------------------
    ! Generic Root Finder: Solves for Energy
    ! ------------------------------------------------------------------
    function find_eigenenergy(n, V, alpha, tp_formula, E_max) result(E_root)
        real(dp), external :: V
        integer, intent(in) :: n
        real(dp), intent(in) :: alpha
        real(dp), intent(in), optional :: E_max
        procedure(turn_point_func) :: tp_formula
        real(dp) :: E_root
        
        real(dp) :: E_min, E_max_val, E_mid
        real(dp) :: target_action, current_action
        real(dp) :: calc_L, calc_R
        integer :: iter
        real(dp), parameter :: TOL_E = 1.0e-7_dp
        
        ! WKB quantization condition:
        ! \int_{x_1}^{x_2} \sqrt{2m(E - V(x))} dx = (n + \alpha) \pi \hbar
        target_action = (real(n, dp) + alpha) * pi * h_bar
        
        E_min = 0.0001_dp
        
        if (present(E_max)) then
            E_max_val = E_max
        else
            E_max_val = 500.0_dp
        end if
        
        ! Bisection Algorithm
        do iter = 1, 1000
            E_mid = 0.5_dp * (E_min + E_max_val)
            
            call tp_formula(E_mid, calc_L, calc_R)
            current_action = wkb_integral(E_mid, V, x_in_L=calc_L, x_in_R=calc_R)
            
            if (abs(current_action - target_action) < TOL_E) exit
            
            if (current_action < target_action) then
                E_min = E_mid ! Energy too low
            else
                E_max_val = E_mid ! Energy too high
            end if
        end do
        
        E_root = E_mid
    end function find_eigenenergy

end module wkb_toolbox