const k_B = 1.380649e-23

struct ReferenceFlowQuantities
    p_ref::Float64
    T_ref::Float64
    rho_ref::Float64
    v_ref::Float64
    n_ref::Float64
    m_ref::Float64
    e_ref::Float64
    c_v_ref::Float64
    R_specific_ref::Float64
    t_ref::Float64
    μ_ref::Float64
    λ_ref::Float64
    Diff_ref::Float64
    Reynolds_ref::Float64
end

function get_v_ref(p_ref, rho_ref)
    return sqrt(p_ref/rho_ref)
end

function p_T_rho_L(p_ref, T_ref, rho_ref, L_ref)
    n_ref = p_ref / (k_B * T_ref)
    m_ref = rho_ref / n_ref
    v_ref = get_v_ref(p_ref, rho_ref)
    t_ref = L_ref / v_ref
    μ_ref = p_ref * t_ref
    λ_ref = (p_ref / T_ref) * v_ref * L_ref
    Diff_ref = v_ref * L_ref

    return ReferenceFlowQuantities(p_ref, T_ref, rho_ref, v_ref, n_ref, m_ref,
                                   k_B * T_ref / m_ref, k_B / m_ref, k_B / m_ref,
                                   t_ref, μ_ref, λ_ref, Diff_ref, rho_ref * v_ref * L_ref / μ_ref)
end

function p_m_rho_L(p_ref, m_ref, rho_ref, L_ref)
    T_ref = m_ref / k_B * p_ref / rho_ref
    return p_T_rho_L(p_ref, T_ref, rho_ref, L_ref)
end

function T_v_rho_L(T_ref, v_ref, rho_ref, L_ref)
    p_ref = rho_ref * v_ref^2
    return p_T_rho_L(p_ref, T_ref, rho_ref, L_ref)
end

Base.Dict(rfq::ReferenceFlowQuantities) = Dict(
    "Reference pressure" => rfq.p_ref,
    "Reference temperature" => rfq.T_ref,
    "Reference density" => rfq.rho_ref,
    "Reference velocity" => rfq.v_ref,
    "Reference number density" => rfq.n_ref,
    "Reference mass" => rfq.m_ref,
    "Reference energy per unit mass" => rfq.e_ref,
    "Reference specific heat" => rfq.c_v_ref,
    "Reference specific gas constant" => rfq.R_specific_ref,
    "Reference time" => rfq.t_ref,
    "Reference viscosity" => rfq.μ_ref,
    "Reference thermal conductivity" => rfq.λ_ref,
    "Reference diffusion coefficient" => rfq.Diff_ref,
    "Reference Reynolds number" => rfq.Reynolds_ref
)
