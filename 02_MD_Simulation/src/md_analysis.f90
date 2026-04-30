module md_analysis
    use md_params
    implicit none
    
contains
    subroutine  velocity_distribution(vel_list, Nstep_total, bin_no, filename)
        integer, intent(in) :: bin_no, Nstep_total
        real(dp), intent(in) :: vel_list(Nmol, Nstep_total)
        character(len=*), intent(in) :: filename

        integer :: i, j, k, count, index_max
        real(dp) :: max_val, min_val, h, s, integration, v
        real(dp) :: KE_avg, KE_tot, v_most, fn_max
        real(dp), allocatable :: fn(:)

        allocate(fn(bin_no))
        fn = 0.0_dp

        max_val = maxval(vel_list)
        min_val = 0.0_dp
        h = (max_val-min_val)/real(bin_no, dp)

        s = min_val
        do k = 1, bin_no
            count = 0
            do j = 10001, Nstep_total
                do i = 1, Nmol
                    if (vel_list(i,j) >= s .and. vel_list(i,j) < (s+h)) then
                        count = count + 1
                    end if
                end do
            end do
            fn(k) = real(count, dp)
            s = s+h
        end do

        call simpson(fn, bin_no, h, integration)

        fn_max = fn(1)
        index_max = 1
        do i = 2, bin_no
            if ( fn(i) > fn_max ) then
                fn_max = fn(i)
                index_max = i
            end if
        end do
        v_most = min_val + real(index_max, dp)*h

        KE_tot = 0.0_dp
        do j = 10001, Nstep_total
            do i = 1, Nmol
                KE_tot = KE_tot + 0.5*vel_list(i,j)**2
            end do
        end do
        KE_avg = KE_tot/real((Nstep_total - 10000)*Nmol, dp)

        open(1004, file=filename, status="replace")
        do i = 1, bin_no
            v = min_val + (real(i, dp) - 0.5_dp)*h
            write(1004, *) v, fn(i)/integration, P_theoretical(v, sqrt(KE_avg)), P_theoretical(v, v_most)
        end do
        close(1004)

        write(*, '(A, G0.10)') "Simulation V_most: ", v_most
        write(*, '(A, G0.10)') "Theoretical V_most: ", sqrt(KE_avg)

        deallocate(fn)
    end subroutine velocity_distribution

    subroutine simpson(fn, bin_no, h, integration)
        real(dp), intent(in) :: fn(:), h
        integer, intent(in) :: bin_no
        real(dp), intent(out) :: integration
        real(dp) :: s1, s2
        integer :: i, j

        s1 = 0.0_dp
        s2 = 0.0_dp

        do i = 2, bin_no - 1, 2
            s1 = s1 + fn(i)
        end do

        do j = 3, bin_no - 2, 2
            s2 = s2 + fn(j)
        end do

        integration = (h/3.0_dp) * (fn(1) + fn(bin_no) + 4.0_dp*s1 + 2.0_dp*s2)
    end subroutine simpson

    function P_theoretical(v, v0) result(P)
        real(dp), intent(in) :: v, v0
        real(dp) :: P
        P = (v/v0**2) * exp(-0.5_dp*(v/v0)**2)
    end function P_theoretical
end module md_analysis