defmodule Problem do 

# defining behaviours. It is equivalent to behaviour in OOP. So a dog should have a behavious called eat. Definitions here only define the types of input and output. The behaviour has to be defined at runtime

	alias Types.Chromosome # refer to the type created. Behaviours will work on the type

	@callback genotype :: Chromosome.t # the genotype behaviour wil take no arguments and return a Chromosome type
	@callback fitness_function(Chromosome.t) :: number() # fitness_function will take a Chromosome type and return a number
	@callback terminate?(Enum.t) :: boolean() # terminate will take an Enumerable representing the population and return a boolean.

end