module md_energy
    use md_params
    implicit none
    
contains
    subroutine calculate_potential(pot)
        real(dp), intent(out) :: pot
        integer :: i, j
        real(dp) :: dx, dy, r2, t1, t2

        pot = 0.0_dp

        do i = 1, Nmol-1
            do j = i+1, Nmol
                dx = x(i) - x(j)
                dy = y(i) - y(j)
                
                if ( dx > Lx/2.0_dp ) then
                    dx = dx - Lx
                else if ( dx < -Lx/2.0_dp) then
                    dx = dx + Lx
                end if
                
                if ( dy > Ly/2.0_dp ) then
                    dy = dy - Ly
                else if ( dy < -Ly/2.0_dp) then
                    dy = dy + Ly
                end if
                
                r2 = dx**2 + dy**2
                t1 = 1.0_dp/r2
                t2 = t1**3

                pot = pot + 4.0_dp *(t2**2-t2)
            end do
        end do
    end subroutine calculate_potential

    subroutine calculate_kinetic(kinetic)
        real(dp), intent(out) :: kinetic
        integer :: i
        real(dp) :: v_sq

        kinetic = 0.0_dp
        do i = 1, Nmol
            v_sq = vx(i)**2 + vy(i)**2
            kinetic = kinetic + 0.5_dp * v_sq
        end do
    end subroutine calculate_kinetic
end module md_energy