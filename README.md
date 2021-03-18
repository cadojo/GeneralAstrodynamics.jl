[![Tests](https://github.com/cadojo/UnitfulAstrodynamics.jl/workflows/Tests/badge.svg)](https://github.com/cadojo/UnitfulAstrodynamics.jl/actions?query=workflow%3ATests)
[![Docs](https://github.com/cadojo/UnitfulAstrodynamics.jl/workflows/Documentation/badge.svg)](https://cadojo.github.io/UnitfulAstrodynamics.jl/stable)

# UnitfulAstrodynamics.jl
Common astrodynamics calculations, with units!

## Features
* Restricted two-body problem equations, states, propagation, and plotting
* Restricted three-body problem equations, states, propagation, and iterative Halo orbit solvers
* N-body problem equations, states, propagation, and plotting
* A collection of fairly accurate planetary constants from our solar system (pulled from [SPICE](https://naif.jpl.nasa.gov/pub/naif/generic_kernels/) kernals)

More to come! In the near term, additional features will include...
* Manifold-based transfer equations and states within the circular restricted three-body problem
* Hohmann-based transfer equations and states within the restricted two-body problem
* Zero-velocity curve plots for circular restricted three-body problem trajectories
* Stability analysis for circular restricted three-body problem states

## Motivation 

This package aims to provide a simple interface for common astrodynamics problems. It was created to learn more about Astrodynamics, and will be developed alongside a Graduate Astrodynamics course at the University of Maryland. The packages [JuliaSpace/Astrodynamics.jl](https://github.com/JuliaSpace/Astrodynamics.jl) and [JuliaAstro/AstroBase.jl](https://github.com/JuliaAstro/AstroBase.jl) are more fully featured. I will continue adding features to this package, but for a more complete feature set, use the packages provided by [JuliaSpace](https://github.com/JuliaSpace) and [JuliaAstro](https://github.com/JuliaAstro).

## Credits

\[1\] Vallado, David A. Fundamentals of astrodynamics and applications. Vol. 12. Springer Science & Business Media, 2001.
* All equations and algorithms within `UnitfulAstrodynamics` are pulled from Vallado's _Fundamentals of Astrodynamics and Applications_, as well as course notes from ENAE 601 (Astrodynamics) at the University of Maryland.

\[2\] [Unitful.jl](https://github.com/PainterQubits/Unitful.jl) and [UnitfulAstro.jl](https://github.com/JuliaAstro/UnitfulAstro.jl) are used for unit handling.

## Usage

Check out the [Getting Started](https://cadojo.github.io/UnitfulAstrodynamics.jl/stable/Overview/getting-started/#Getting-Started) documentation for code examples, and more detail about using this package. 