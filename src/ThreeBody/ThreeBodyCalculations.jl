#
# ThreeBodyCalculations.jl
# Calculations for the Circular Restricted
# Three Body Problem.
#

"""
Returns time scale factor, `Tₛ`.
"""
time_scale_factor(a, μ₁, μ₂) = orbital_period(a, μ₁+μ₂)

"""
Returns nondimensional length unit, `DU`.
"""
nondimensionalize_length(rᵢ, a) = upreferred.(rᵢ ./ a)

"""
Returns nondimensional velocity unit, `DU/DT`.
"""
nondimensionalize_velocity(vᵢ, a, Tₛ) = upreferred.(vᵢ ./ (a / Tₛ))

"""
Returns nondimensional time unit, `DT`.
"""
nondimensionalize_time(t, a, μ₁, μ₂) = t / time_scale_factor(a, μ₁, μ₂)

"""
Returns nondimensional mass parameter, `μ`.
"""
nondimensionalize_mass_parameter(μ₁, μ₂) = min(μ₁,μ₂) / (μ₁+μ₂)

"""
Returns nondimensional form of (`Unitful`) scalar posiion.
"""
nondimensionalize(rᵢ::R, a::A) where {
        R<:Length, A<:Length
    } = nondimensionalize_length(rᵢ, a)

"""
Returns nondimensional form of (`Unitful`) position vector.
"""
nondimensionalize(rᵢ::R, a::A) where {
        U<:Length, R<:AbstractVector{U}, A<:Length
    } = nondimensionalize_length(rᵢ, a)

"""
Returns nondimensional form of (`Unitful`) scalar velocity.
"""
nondimensionalize(vᵢ::V, a::A, Tₛ::T) where {
        V<:Velocity, A<:Length, T<:Time
    } = nondimensionalize_velocity(vᵢ, a, Tₛ)

"""
Returns nondimensional form of (`Unitful`) velocity vector.
"""
nondimensionalize(vᵢ::V, a::A, Tₛ::T) where {
        U<:Velocity, V<:AbstractVector{U}, A<:Length, T<:Time
    } = nondimensionalize_velocity(vᵢ, a, Tₛ)

"""
Returns nondimensional form of (`Unitful`) velocity vector.
"""
nondimensionalize(vᵢ::V, a::A, μ₁::U1, μ₂::U2) where {
        U<:Velocity, V<:AbstractVector{U}, A<:Length, U1<:MassParameter, U2<:MassParameter
    } = nondimensionalize_velocity(vᵢ, a, time_scale_factor(a, μ₁, μ₂))

"""
Returns nondimensional form of (`Unitful`) time duration.
"""
nondimensionalize(t::T1, Tₛ::T2) where {
        T1<:Time, T2<:Time
    } = t / Tₛ

"""
Returns nondimensional form of (`Unitful`) time duration.
"""
nondimensionalize(t::T1, a::A, μ₁::U1, μ₂::U2) where {
        T1<:Time, A<:Length, U1<:MassParameter, U2<:MassParameter
    } = nondimensionalize(t, time_scale_factor(a, μ₁, μ₂))

"""
Returns nondimensional form of (`Unitful`) graviational parameters.
"""
nondimensionalize(μ₁::U1, μ₂::U2) where {
        U1<:MassParameter, U2<:MassParameter
    } = min(μ₁, μ₂) / (μ₁+μ₂)

"""
Returns nondimensional Circular Restricted Three-body State.
"""
function nondimensionalize(r₃::R, v₃::V, Δt::T, μ₁::U1, μ₂::U2, a::A) where {
        RT<:Length, R<:AbstractVector{RT},
        VT<:Velocity, V<:AbstractVector{VT},
        T<:Time, U1<:MassParameter, U2<:MassParameter,
        A<:Length
    }

    Tₛ = time_scale_factor(a, μ₁, μ₂)
    return nondimensionalize(r₃, a), 
           nondimensionalize(v₃, a, Tₛ),
           nondimensionalize(Δt, Tₛ),
           nondimensionalize(μ₁, μ₂)

end

"""
Returns dimensional length units.
"""
redimensionalize_length(rᵢ, a) = upreferred(rᵢ .* a)

"""
Returns dimensional velocity units.
"""
redimensionalize_velocity(vᵢ, a, Tₛ) = vᵢ .* (a / Tₛ)

"""
Returns dimensional time unit.
"""
redimensionalize_time(t, a, μ₁, μ₂) = t * time_scale_factor(a, μ₁, μ₂)

"""
Returns dimensional (inertial) form of (`Unitful`) scalar posiion.
"""
redimensionalize(rᵢ::R, a::A) where {
        R<:Length, A<:Length
    } = redimensionalize_length(rᵢ, a)

"""
Returns dimensional (inertial) form of (`Unitful`) position vector.
"""
redimensionalize(rᵢ::R, a::A) where {
        U<:Length, R<:AbstractVector{U}, A<:Length
    } = redimensionalize_length(rᵢ, a)


"""
Returns dimensional (inertial) form of (`Unitful`) scalar velocity.
"""
redimensionalize(vᵢ::V, a::A) where {
        V<:Velocity, A<:Length
    } = redimensionalize_length(vᵢ, a)


"""
Returns dimensional (inertial) form of (`Unitful`) velocity vector.
"""
redimensionalize(vᵢ::V, a::A, Tₛ::T) where {
        U<:Velocity, V<:AbstractVector{U}, A<:Length, T<:Time
    } = redimensionalize_velocity(vᵢ, a, Tₛ)

"""
Returns dimensional (inertial) form of (`Unitful`) velocity vector.
"""
redimensionalize(vᵢ::V, a::A, μ₁::U1, μ₂::U2) where {
        U<:Velocity, V<:AbstractVector{U}, A<:Length, U1<:MassParameter, U2<:MassParameter
    } = redimensionalize_velocity(vᵢ, a, time_scale_factor(a, μ₁, μ₂))

"""
Returns dimensional (inertial) form of (`Unitful`) time duration.
"""
redimensionalize(t::T1, Tₛ::T2) where {
        T1<:Time, T2<:Time
    } = t / Tₛ

"""
Returns dimensional (inertial) form of (`Unitful`) time duration.
"""
redimensionalize(t::T1, a::A, μ₁::U1, μ₂::U2) where {
        T1<:Time, A<:Length, U1<:MassParameter, U2<:MassParameter
    } = redimensionalize(t, time_scale_factor(a, μ₁, μ₂))

"""
Returns the spacecraft's nondimensional position w.r.t. body 1 (or 2).
"""
nondimensional_radius(r, xᵢ=0) = √( (r[1]-xᵢ)^2 + r[2]^2 + r[3]^2 )

"""
Returns the potential energy `U`.
"""
potential_energy(r, μ) = (r[1]^2 + r[2]^2)/2 + ((1-μ)/nondimensional_radius(r,-μ)) + (μ/nondimensional_radius(r,1-μ))

"""
Returns the Jacobi Constant `C`.
"""
jacobi_constant(r, v, μ) = 2*potential_energy(r, μ) - (v⋅v)

"""
Given the Synodic frame vector, returns the vector in the inertial reference frame.
"""
function inertial(vecₛ, t, ω=1.0u"rad"/unit(t))

    θ = ω*t
    ᴵTₛ = @SMatrix [
        cos(θ) sin(θ) 0
       -sin(θ) cos(θ) 0
        0      0      1
    ]

    return  ᴵTₛ * vecₛ

end

"""
Returns the position and velocity vectors in the synodic (rotating) reference frame.
"""
synodic(rᵢ, vᵢ, a, Tₛ) =  nondimensionalize(rᵢ, a), nondimensionalize(vᵢ, a, Tₛ)

"""
Returns the lagrange points for a CR3BP system.

__Arguments:__ 
- `μ`: Non-dimensional mass parameter for the CR3BP system.
- `L`: Langrange points requested, must be in range [1,5]

__Outputs:__
- Tuple of Lagrange points
- Throws `ArgumentError` if L is out of range [1,5]

__References:__
- [Rund, 2018](https://digitalcommons.calpoly.edu/theses/1853/)
"""
function lagrange(μ, L=1:5)
    
    if !all(L[i] ∈ (1,2,3,4,5) for i ∈ 1:length(L))
        throw(ArgumentError("Requested lagrange points must be in range [1,5]"))
    end

	expressions = @SVector [
		x -> x - (1-μ)/(x+μ)^2 + μ/(x+μ-1)^2,
		x -> x - (1-μ)/(x+μ)^2 - μ/(x+μ-1)^2,
		x -> x + (1-μ)/(x+μ)^2 + μ/(x+μ+1)^2
	]
	
	return  (map(f->[find_zero(f, (-3,3)), 0, 0], expressions)..., 
			[(1/2) - μ, √(3)/2, 0], [(1/2) - μ, -√(3)/2, 0])[L]
	
end

"""
Returns non-dimensional acceleration for CR3BP state.
"""
function accel(rₛ, vₛ, μ)

    x₁ = -μ
    x₂ = 1-μ
    r₁ = nondimensional_radius(rₛ, x₁)
    r₂ = nondimensional_radius(rₛ, x₂)

    return [
         2vₛ[2] + rₛ[1] - (1-μ)*(rₛ[1] - x₁) / r₁^3 - μ*(rₛ[1] - x₂) / r₂^3,
        -2vₛ[1] + rₛ[2] - ((1-μ) / r₁^3 + (μ / r₂^3)) * rₛ[2],
        -((1-μ) / r₁^3 + (μ / r₂^3)) * rₛ[3]
    ]
    
end