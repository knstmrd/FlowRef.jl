# FlowRef.jl

**FlowRef.jl** is a small library for computation of consistent reference quantities for inviscid and viscous flows.
These are helpful when using non-dimensionalized/scaled flow equations.

## Usage

The package defines a `ReferenceFlowQuantities` struct that stores all necessary reference quantities for scaling
of the compressible Navier-Stokes equations. A derivation of the reference quantities in the context of multi-species
multi-temperature Navier-Stokes equations can be [found here](https://github.com/knstmrd/FlowRef.jl/blob/main/eqns/equations_scaling.pdf).
To ensure that the quantities are computed in a consistent manner, utility functions are provided that return
a `ReferenceFlowQuantities` instance given a set of independent reference quantities that are used define all
other reference values:

* `p_m_rho_L(p_ref, m_ref, rho_ref, L_ref)` - computes all reference quantities given a reference pressure `p_ref`,
    reference mass `m_ref`, reference density `rho_ref`, and reference `L_ref`
* `p_T_rho_L(p_ref, T_ref, rho_ref, L_ref)` - computes all reference quantities given a reference pressure `p_ref`,
    reference temperature `T_ref`, reference density `rho_ref`, and reference `L_ref`
* `T_v_rho_L(T_ref, v_ref, rho_ref, L_ref)` - computes all reference quantities given a reference temperature `T_ref`,
    reference velocity `v_ref`, reference density `rho_ref`, and reference `L_ref`

A dictionary may be instantiated from `ReferenceFlowQuantities` instance `rfq` by simply calling `dict_rfq = Dict(rfq)`.

Example usage:
```julia
rfq = p_m_rho_L(101325.0, 4.65e-26, 1.1375, 1.0) # atmospheric pressure, N2 molecular mass, 1.1375 kg/m^3 density, 1 m reference length
println(rfq.T_ref)  # 300.0094102901551
println(rfq.v_ref)  # 298.4575733281417

# we can use computed quantities and check that we get our reference pressure and mass
rfq2 = T_v_rho_L(rfq.T_ref, rfq.v_ref, 1.1375, 1.0)
println(rfq2.p_ref)  # 101324.99999999999
println(rfq2.m_ref)  # 4.650000000000001e-26
```

## Computed quantities

The `ReferenceFlowQuantities` struct has the following fields:

* `p_ref`:  reference pressure
* `T_ref`: reference temperature
* `rho_ref`: reference density
* `v_ref`: reference velocity
* `n_ref`: reference number density
* `m_ref`: reference mass
* `e_ref`: reference specific energy (per unit mass)
* `c_v_ref`: reference specific heat
* `R_specific_ref`: reference specific gas constant
* `t_ref`: reference time
* `μ_ref`: reference viscosity coefficient
* `λ_ref`: reference thermal conductivity coefficient
* `Diff_ref`: reference diffusion coefficient
* `Reynolds_ref`: reference Reynolds number