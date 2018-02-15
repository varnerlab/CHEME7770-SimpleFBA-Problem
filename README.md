## Simple Flux Balance Analysis (FBA) problem
Flux balance analysis (along with a related approach called Metabolic Flux Analysis or MFA) is a widely used technique to estimate intracellular fluxes (reaction rates, typically in units of mmol/gDW-hr) given measurements of the specific uptake and secretion rates into/from a cell. Flux balance analysis is posed as a Linear Programming (LP) problem where the stoichiometric material balances, and bounds on the permissible values of the fluxes serve as constraints on the calculation.
For more information on flux balance analysis see:

[Orth et al, (2010) What is flux balance analysis? Nat. Biotechnology, 28:245-248](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3108565/).

### Installation and Requirements
You can download this FBA example repository as a zip file, or clone or pull it by using the command (from the command-line):

	$ git pull https://github.com/varnerlab/CHEME7770-SimpleFBA-Problem

or

	$ git clone https://github.com/varnerlab/CHEME7770-SimpleFBA-Problem

To execute the flux balance analysis calculation, [Julia](https://julialang.org) must be installed on your machine along with the
the Julia plugin for the [GLPK](https://github.com/JuliaOpt/GLPK.jl) linear programming solver. To install the GLPK program issue the command:

  	julia> Pkg.add("GLPK")

in the Julia REPL.

### What is the example problem?

![example](./figs/Network.png)

The abstracted metabolic network has four intracellular reactions and three intracellular metabolites A, B and C which can be exchanged with the extracellular environment.
Extracellular A, B and C can be exchanged with hypothetical boundary metabolites.

### How do we solve the example problem?
You solve the flux balance analysis procedure by executing either the default driver function [Solve.jl](./src/Solve.jl) (or a custom driver routine that you have written).
The default driver routine is given by:

```
include("Include.jl")

# load the data dictionary -
data_dictionary = DataDictionary(0,0,0)

# solve the lp problem -
(objective_value, flux_array, dual_array, uptake_array, exit_flag, status_flag) = FluxDriver(data_dictionary)
```


The default routine loads the required files into the Julia session, then loads a [Julia dictionary](https://docs.julialang.org/en/release-0.5/stdlib/collections/?highlight=dict#Base.Dict) holding the parameters (species and flux bounds, and the objective coefficient vector) required by GLPK. The data dictionary is then passed to FluxDriver which sets up the flux balance analysis problem, calls the LP solver and returns
the flux solution. The main point of customization is in data dictionary, see the [maximize_c_script.jl](./maximize_c_script.jl) for an example.
