const k_B = 1.380649e-23

function get_v_ref(p_ref, rho_ref)
    return sqrt(p_ref/rho_ref)
end

function p_T_rho_L(p_ref, T_ref, rho_ref, L_ref)
    n_ref = p_ref / (k_B * T_ref)
    m_ref = rho_ref / n_ref
    v_ref = get_v_ref(p_ref, rho_ref)
    t_ref = L_ref / v_ref
    μ_ref = p_ref * t_ref

    return Dict("p_ref" => p_ref,
                "T_ref" => T_ref,
                "rho_ref" => rho_ref,
                "v_ref" => v_ref,
                "n_ref" => n_ref,
                "m_ref" => m_ref,
                "e_ref" => k_B * T_ref / m_ref,
                "cv_ref" => k_B / m_ref,
                "R_specific_ref" => k_B / m_ref,
                "t_ref" => t_ref,
                "μ_ref" => μ_ref,
                "Reynolds_ref" => rho_ref * v_ref * L_ref / μ_ref
                )
end

function p_m_rho_L(p_ref, m_ref, rho_ref, L_ref)
    T_ref = m_ref / k_B * p_ref / rho_ref
    return p_T_rho_L(p_ref, T_ref, rho_ref, L_ref)
end

function T_v_rho_L(T_ref, v_ref, rho_ref, L_ref)
    p_ref = rho_ref * v_ref^2
    return p_T_rho_L(p_ref, T_ref, rho_ref, L_ref)
end
