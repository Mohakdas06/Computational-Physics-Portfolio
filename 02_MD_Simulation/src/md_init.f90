module md_init
    use md_params
    implicit none
    
contains
    subroutine init_system(Nx, Ny, v_initial)
        integer, intent(in) :: Nx, Ny
        real(dp), intent(in) :: v_initial

        integer :: i, j, p
        real(dp) :: rnd, vx_tot, vy_tot

        allocate(x(Nmol), y(Nmol), vx(Nmol), vy(Nmol))
        allocate(Fx(Nmol), Fy(Nmol), Fx1(Nmol), Fy1(Nmol))

        call random_seed()

        p = 0
        do i = 1, Nx
            do j = 1, Ny
                p = p + 1
                if (p > Nmol) exit

                call random_number(rnd)
                x(p) = (Lx/real(Nx,dp))*(i-0.25_dp*rnd)

                call random_number(rnd)
                y(p) = (Ly/real(Ny,dp))*(j-0.25_dp*rnd)
            end do
        end do

        vx_tot = 0.0_dp
        vy_tot = 0.0_dp

        do i = 1, Nmol
            call random_number(rnd)
            vx(i) = v_initial*(rnd-0.5_dp)

            call random_number(rnd)
            vy(i) = v_initial*(rnd-0.5_dp)

            vx_tot = vx_tot + vx(i)
            vy_tot = vy_tot + vy(i)
        end do
        vx_tot = vx_tot/real(Nmol, dp)
        vy_tot = vy_tot/real(Nmol, dp)

        do i = 1, Nmol
            vx(i) = vx(i) - vx_tot
            vy(i) = vy(i) - vy_tot
        end do
    end subroutine init_system
end module md_init