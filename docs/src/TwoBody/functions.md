## `TwoBody` Calculations

For convenience, common `TwoBody` problem calculations are provided through functions. 
Often, these functions are provided with common arguments (such as `orbital_period(a,μ)`), _and_ with [`TwoBody` Data Structures](@ref) arguments (such as `orbital_period(::Orbit)`).

## Orbital Representations

You can convert between Cartesian and Keplerian `TwoBody` orbital representations by using [`cartesian`](@ref) and [`keplerian`](@ref).

```@docs
cartesian
keplerian
inertial
perifocal
```

## Kepler's Prediction Problem

The function `kepler` can solve Kepler's Prediction Problem for an `Orbit`.

```@docs
kepler
```

## Common `TwoBody` Problem Calculations

```@docs
semimajor_axis
eccentricity
eccentricity_vector
inclination
true_anomoly
periapsis_radius
apoapsis_radius
periapsis_velocity
apoapsis_velocity
radius
velocity
orbital_period
time_since_periapsis
mean_motion
semi_parameter
conic_anomoly
specific_angular_momentum
specific_angular_momentum_vector
specific_energy
conic
isinvalid
isapprox
isequal
```