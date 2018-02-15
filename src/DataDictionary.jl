# ----------------------------------------------------------------------------------- #
# Copyright (c) 2017 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #

function maximize_b_and_c_with_v4_dictionary(time_start,time_stop,time_step)

	# Load the default data dictionary -
	data_dictionary = DataDictionary(time_start,time_stop,time_step)

	# Modify the data dictionary -
	# Update the objective coefficient array -
	objective_coefficient_array = data_dictionary["objective_coefficient_array"]
	objective_coefficient_array[10] = -1

	# Update bounds -
	default_flux_bounds_array = data_dictionary["default_flux_bounds_array"]
	default_flux_bounds_array[7,1] = 0.3  	# force C to be produced at 0.3 mmol/gDW-hr
	default_flux_bounds_array[7,2] = 0.3 	# force C to be produced at 0.3 mmol/gDW-hr

	default_flux_bounds_array[2,1] = 0.1	# some flux back to A from B
	default_flux_bounds_array[2,2] = 0.1	# some flux back to A from B

	default_flux_bounds_array[11,2] = 0.0
	default_flux_bounds_array[13,2] = 0.0

	# return -
	return data_dictionary
end

function maximize_b_and_c_dictionary(time_start,time_stop,time_step)

	# Load the default data dictionary -
	data_dictionary = DataDictionary(time_start,time_stop,time_step)

	# Modify the data dictionary -
	# Update the objective coefficient array -
	objective_coefficient_array = data_dictionary["objective_coefficient_array"]
	objective_coefficient_array[10] = -1

	# Update bounds -
	default_flux_bounds_array = data_dictionary["default_flux_bounds_array"]
	default_flux_bounds_array[7,1] = 0.3  	# force C to be produced at 0.3 mmol/gDW-hr
	default_flux_bounds_array[7,2] = 0.3 	# force C to be produced at 0.3 mmol/gDW-hr
	default_flux_bounds_array[11,2] = 0.0
	default_flux_bounds_array[13,2] = 0.0

	# return -
	return data_dictionary
end

function maximize_c_dictionary(time_start,time_stop,time_step)

	# Load the default data dictionary -
	data_dictionary = DataDictionary(time_start,time_stop,time_step)

	# Modify the data dictionary -
	# Update the objective coefficient array -
	objective_coefficient_array = data_dictionary["objective_coefficient_array"]
	objective_coefficient_array[12] = -1 # its negative because we min by default

	# Update bounds -
	default_flux_bounds_array = data_dictionary["default_flux_bounds_array"]
	default_flux_bounds_array[13,2] = 0.0

	# return -
	return data_dictionary
end

# ----------------------------------------------------------------------------------- #
# Function: DataDictionary
# Description: Holds simulation and model parameters as key => value pairs in a Julia Dict()
# Generated on: 2017-03-21T10:46:19.757
#
# Input arguments:
# time_start::Float64 => Simulation start time value (scalar)
# time_stop::Float64 => Simulation stop time value (scalar)
# time_step::Float64 => Simulation time step (scalar)
#
# Output arguments:
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model and simulation parameters as key => value pairs
# ----------------------------------------------------------------------------------- #
function DataDictionary(time_start,time_stop,time_step)

	# Load the stoichiometric network from disk -
	stoichiometric_matrix = readdlm("Network.dat");

	# Setup default flux bounds array -
	default_bounds_array = [

		0	100.0	;	# 1 A_c --> B_c
		0	100.0	;	# 2 B_c --> A_c
		0	100.0	;	# 3 A_c --> C_c
		0	100.0	;	# 4 C_c --> B_c
		0	100.0	;	# 5 A_x --> A_c
		0	100.0	;	# 6 B_c --> B_x
		0	100.0	;	# 7 C_c --> C_x
		0	100.0	;	# 8 A_x --> A_e
		0	100.0	;	# 9 A_e --> A_x
		0	100.0	;	# 10 B_x --> B_e
		0	100.0	;	# 11 B_e --> B_x
		0	100.0	;	# 12 C_x --> C_e
		0	100.0	;	# 13 C_e --> C_x
	];

	# Setup default species bounds array -
	species_bounds_array = [

		0.0	0.0	;	# 1 A_c
		0.0	0.0	;	# 2 A_x
		0.0	0.0	;	# 3 B_c
		0.0	0.0	;	# 4 B_x
		0.0	0.0	;	# 5 C_c
		0.0	0.0	;	# 6 C_x

		-1.0	0.0	;	# 7 A_e
		-1.0	1.0	;	# 8 B_e
		-1.0	1.0	;	# 9 C_e
	];

	# Setup the objective coefficient array -
	objective_coefficient_array = [

		0.0	;	# 1 R1::A_c --> B_c
		0.0	;	# 2 R1_reverse::B_c --> A_c
		0.0	;	# 3 R2::A_c --> C_c
		0.0	;	# 4 R3::C_c --> B_c

		0.0	;	# 5 A_transport::A_x --> A_c
		0.0	;	# 6 B_transport::B_c --> B_x
		0.0	;	# 7 C_transport::C_c --> C_x
		0.0	;	# 8 A_exchange::A_x --> A_e
		0.0	;	# 9 A_exchange_reverse::A_e --> A_x

		0.0	;	# 10 B_exchange::B_x --> B_e
		0.0	;	# 11 B_exchange_reverse::B_e --> B_x
		0.0	;	# 12 C_exchange::C_x --> C_e
		0.0	;	# 13 C_exchange_reverse::C_e --> C_x
	];

	# Min/Max flag - default is minimum -
	is_minimum_flag = true

	# List of reation strings - used to write flux report
	list_of_reaction_strings = [
		"R1::A_c --> B_c"
		"R1_reverse::B_c --> A_c"
		"R2::A_c --> C_c"
		"R3::C_c --> B_c"
		"A_transport::A_x --> A_c"
		"B_transport::B_c --> B_x"
		"C_transport::C_c --> C_x"
		"A_exchange::A_x --> A_e"
		"A_exchange_reverse::A_e --> A_x"
		"B_exchange::B_x --> B_e"
		"B_exchange_reverse::B_e --> B_x"
		"C_exchange::C_x --> C_e"
		"C_exchange_reverse::C_e --> C_x"
	];

	# List of metabolite strings - used to write flux report
	list_of_metabolite_symbols = [
		"A_c"
		"A_x"
		"B_c"
		"B_x"
		"C_c"
		"C_x"
		"A_e"
		"B_e"
		"C_e"
	];

	# =============================== DO NOT EDIT BELOW THIS LINE ============================== #
	data_dictionary = Dict{AbstractString,Any}()
	data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
	data_dictionary["objective_coefficient_array"] = objective_coefficient_array
	data_dictionary["default_flux_bounds_array"] = default_bounds_array;
	data_dictionary["species_bounds_array"] = species_bounds_array
	data_dictionary["list_of_reaction_strings"] = list_of_reaction_strings
	data_dictionary["list_of_metabolite_symbols"] = list_of_metabolite_symbols
	data_dictionary["is_minimum_flag"] = is_minimum_flag
	# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #
	return data_dictionary
end
