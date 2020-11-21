using Documenter
using DocStringExtensions
using UnitfulAstrodynamics

source = true
UnitfulAstrodynamics.include_sourcecode(source)
UnitfulAstrodynamics.AstroPlots.include_sourcecode(source)
UnitfulAstrodynamics.CommonTypes.include_sourcecode(source)
UnitfulAstrodynamics.Maneuvers.include_sourcecode(source)
UnitfulAstrodynamics.NBody.include_sourcecode(source)
UnitfulAstrodynamics.Propagators.include_sourcecode(source)
UnitfulAstrodynamics.ThreeBody.include_sourcecode(source)
UnitfulAstrodynamics.TwoBody.include_sourcecode(source)

makedocs(modules=[UnitfulAstrodynamics],
    format=Documenter.HTML(),
    sitename="UnitfulAstrodynamics.jl",
    pages=[
        "Guide" => "index.md",
        "Overview" => Any[
            "About" => "Overview/about.md",
            "Getting Stated" => "Overview/getting-started.md"
        ],
        "`TwoBody`" => Any[
            "Data Structures and Types" => "TwoBody/types.md",
            "Functions" => "TwoBody/functions.md"
        ],
        "`NBody`" => Any[
            "Data Structures and Types" => "NBody/types.md",
            "Functions" => "NBody/functions.md"
        ],
        "`Propagators`" => Any[
            "Data Structures and Types" => "Propagators/types.md",
            "Functions" => "Propagators/functions.md"
        ],
        "`Maneuvers`" => Any[
            "Data Structures and Types" => "Maneuvers/types.md",
            "Functions" => "Maneuvers/functions.md"
        ],
        "`AstroPlots`" => Any[
            "Functions" => "AstroPlots/functions.md"
        ],
        "Common `CommonTypes`" => Any[
            "Types" => "CommonTypes/types.md"
        ]
    ]
)

deploydocs(
    target = "build",
    repo="github.com/cadojo/UnitfulAstrodynamics.jl.git",
    branch = "gh-pages",
    deps   = nothing,
    make   = nothing,
    devbranch = "main",
    versions = ["stable" => "v^", "manual", "v#.#", "v#.#.#"],
)
