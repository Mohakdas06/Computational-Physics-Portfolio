module md_forces
    use md_params
    implicit none
contains
    
    subroutine calculate_forces()
        integer :: i, j
        real(dp) :: dx, dy, r2, t1, t2, f_scalar

        Fx = 0.0_dp
        Fy = 0.0_dp

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
                f_scalar = 24.0_dp * t1 *(2.0_dp*t2**2-t2)
                
                Fx(i) = Fx(i) + dx * f_scalar
                Fy(i) = Fy(i) + dy * f_scalar
                
                Fx(j) = Fx(j) - dx * f_scalar
                Fy(j) = Fy(j) - dy * f_scalar
            end do
        end do
    end subroutine calculate_forces
end module md_forces