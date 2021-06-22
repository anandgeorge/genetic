defmodule Types.Chromosome do

	@type t :: %__MODULE__ { 
		# __MODULE__ gets replaced with the name of the module. So the struct will be Types.Chromosome. t is a standard type for defining structs
		genes: Enum.t,
		size: integer(),
		fitness: number(),
		age: integer()
	}

	@enforce_keys :genes # ensure that the struct has the genes key. So we have four fields, three initialised and one mandatory
	defstruct [:genes, size: 0, fitness: 0, age: 0] # define a struct with 
end

