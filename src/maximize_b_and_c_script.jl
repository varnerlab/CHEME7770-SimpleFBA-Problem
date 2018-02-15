# Script to maximize the production of metabolite B_e when C_e is being produced 
# Based upon the generated solve script -

# Include -
include("Include.jl")

# load up specific version of the data dictionary -
data_dictionary = maximize_b_and_c_dictionary(0.0,0.0,0.0)

# solve the lp problem -
# ------------------------------------------------------------------------------------------------------------- #
# What is returned?
# objective_value   Value of the objective function at the optimal solution
# flux_array        R-dim array of metabolic flux values at the optimum (mmol/gdw-hr)
# dual_array        LP dual solution at the optimum (later)
# uptake_array      S*flux_array at the optimum value (uptake/secretion of unbalanced metabolites; mmol/gdw-hr)
# exit_flag         Exit condition returned by solver = 0 if calculation succeded (not neccesarily optimal )
# status_flag       Optimality condition = 5 if optimal
# ------------------------------------------------------------------------------------------------------------- #
(objective_value, flux_array, dual_array, uptake_array, exit_flag, status_flag) = FluxDriver(data_dictionary)

# Print on the fluxes that are active
show_flux_profile(flux_array,0.0001,data_dictionary)
