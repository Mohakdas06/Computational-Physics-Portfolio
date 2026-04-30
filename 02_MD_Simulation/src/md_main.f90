program md_main
    use md_params
    use md_init
    use md_forces
    use md_integrator
    use md_energy
    use md_analysis
    implicit none
    
    integer :: step, i, Nx, Ny
    real(dp) :: KE, PE, TE
    real(dp) :: v_initial
    real(dp), allocatable :: v_history(:,:)
    character(len=256) :: velocity_dat

    velocity_dat = "data_25/Velocity_dist.dat"
    open(1000, file="data_25/Initial.dat", status="replace")
    open(1001, file="data_25/Final.dat", status="replace")
    open(1002, file="data_25/Energy.dat", status="replace")

    Nmol = 25
    Nstep = 100000
    Nx = ceiling(sqrt(real(Nmol, dp)))
    Ny = ceiling(real(Nmol, dp)/real(Nx, dp))
    dt = 0.01_dp
    Lx = 4.0_dp*sqrt(real(Nmol, dp))
    Ly = 4.0_dp*sqrt(real(Nmol, dp))
    v_initial = 5.0_dp

    call init_system(Nx, Ny, v_initial)
    allocate(v_history(Nmol, Nstep))

    do i = 1, Nmol
        write(1000, *) x(i), y(i), vx(i), vy(i)
    end do
    
    call calculate_forces()
    
    do step = 1, Nstep
        call integrate_step()
        
        do i = 1, Nmol
            v_history(i, step) = sqrt(vx(i)**2 + vy(i)**2)
        end do
        
        if ( step > 10000 ) then
            call calculate_kinetic(KE)
            call calculate_potential(PE)
            TE = KE + PE
            write(1002, *) step, KE, PE, TE
        end if
    end do

    do i = 1, Nmol
        write(1001, *) x(i), y(i), vx(i), vy(i)
    end do
    
    write(*, '(A)') "Simulation completed successfully."
    close(1000)
    close(1001)
    close(1002)
    
    write(*, '(A)') "Analyzing velocity distribution..."
    call velocity_distribution(v_history, Nstep, 1000, velocity_dat)
end program md_main