module md_integrator
    use md_params
    use md_forces
    implicit none
    
contains
    subroutine integrate_step()
        integer :: i

        do i = 1, Nmol
            x(i) = x(i) + dt*vx(i) + 0.5_dp * Fx(i)*dt**2
            y(i) = y(i) + dt*vy(i) + 0.5_dp * Fy(i)*dt**2

            if ( x(i) > Lx ) then
                x(i) = x(i) - Lx
            else if ( x(i) < 0.0_dp ) then
                x(i) = x(i) + Lx
            end if

            if ( y(i) > Ly ) then
                y(i) = y(i) - Ly
            else if ( y(i) < 0.0_dp ) then
                y(i) = y(i) + Ly
            end if
        end do

        do i = 1, Nmol
            Fx1(i) = Fx(i)
            Fy1(i) = Fy(i)
        end do

        call calculate_forces()

        do i = 1, Nmol
            vx(i) = vx(i) + 0.5_dp * dt * (Fx(i) + Fx1(i))
            vy(i) = vy(i) + 0.5_dp * dt * (Fy(i) + Fy1(i))
        end do
    end subroutine integrate_step
end module md_integrator