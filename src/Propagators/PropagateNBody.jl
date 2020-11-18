#
# Propagator for the NBody problem.
#

"""
    MultibodyPropagationResult{T,B} <: PropagationResult

Struct to hold n-body propagation results.
"""
struct MultibodyPropagationResult{T,B} <: PropagationResult

    t::T
    step::B
    ode_solution::ODESolution

end

"""
    nbody_tic

Currently not exported. Used for n-body numerical integration.
"""
function nbody_tic(u, p, t)

    ∂u = ComponentArray(body = map(x->ComponentVector(r̅=SVector(0.0, 0.0, 0.0), v̅=SVector(0.0, 0.0, 0.0)), u.body))
    for i = 1:length(u.body)

        ∂u.body[i].r̅ = u.body[i].v̅
        for j = 1:length(u.body)

            if i ≠ j
                ∂u.body[i].v̅ += ((p.m[i] * p.m[j]) / norm(u.body[j].r̅ .- u.body[i].r̅)^3 * (u.body[j].r̅ .- u.body[i].r̅))
            end    

        end
        ∂u.body[i].v̅ *= (p.G / p.m[i])

    end

    return ∂u

end

"""
    propagate(sys::MultibodySystem, Δt::Unitful.Quantity, ode_alg::OrdinaryDiffEqAlgorithm = Tsit5(); kwargs...)

Uses OrdinaryDiffEq solvers to propagate `sys` Δt into the future.
All keyword arguments are passed directly to OrdinaryDiffEq solvers.
"""
function propagate(sys::MultibodySystem, Δt::Unitful.Quantity, ode_alg::OrdinaryDiffEqAlgorithm = Tsit5(); kwargs...)
   
    # Referencing:
    # [1] https://diffeq.sciml.ai/v4.0/tutorials/ode_example.html
    # [2] https://github.com/SciML/DifferentialEquations.jl/issues/393#issuecomment-658210231
    # [3] https://discourse.julialang.org/t/smart-kwargs-dispatch/14571/15

    # Set default kwargs (modified from [3])
    defaults = (;  reltol=1e-14, abstol=1e-14)
    options = merge(defaults, kwargs)

    u₀ = ComponentArray(body=(map(b -> ComponentArray((r̅=ustrip.(u"m", b.r̅), v̅=ustrip.(u"m/s", b.v̅))), sys.body)))
    tspan = (0.0, ustrip(u"s", Δt))
    params = ComponentArray((G=6.6743e-11, m=map(b->ustrip(u"kg",b.m), sys.body)))

    problem = ODEProblem(nbody_tic, u₀, tspan, params)

    sols = solve(problem, ode_alg; options...)

    bodies = map(x->MultibodySystem(
                        map(i->Body(u"m" * x.body[i].r̅, u"m/s" * x.body[i].v̅, sys.body[i].m), 
                        1:length(sys.body))), 
                    sols.u)

    return MultibodyPropagationResult(
        u"s" * sols.t,
        bodies,
        sols
    )

end
    
    



    