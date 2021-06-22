#genotype = fn -> for _ <- 1..1000, do: Enum.random(0..1) end

#fitness_function = fn chromosome -> Enum.sum(chromosome) end
#max_fitness = 1000

#soln = Genetic.run(fitness_function, genotype, max_fitness)

#IO.write("\n")
#IO.inspect(soln)

defmodule OneMax do
	@behaviour Problem # This is defined here so that implementions are linked to this behaviour.
	alias Types.Chromosome

	@impl true
	def genotype do
		genes = for _ <- 1..42, do: Enum.random(0..1)
		%Chromosome{genes: genes, size: 42}
	end

	@impl true
	def fitness_function(chromosome), do: Enum.sum(chromosome.genes)

	@impl true
	def terminate?([best | _]), do: best.fitness == 42
end

soln = Genetic.run(OneMax)
IO.write("\n")
IO.inspect(soln)

# Steps to solve the problem
# Define a Chromosome type / struct. See types/chromosome.ex for details. Dog has four feet, eyes etc.
# Define the behaviour that goes with these types. See problem.ex  Dog barks (quitely or loudly), eats (no of bones), runs (fast or slow) etc.
# Define the algorithms. See genetic.ex i.e. Define specific implementations of these behaviours. Dog eats > runs -> in the following sequence.
# Create implementations of the behaviour defined earlier. See one_max.exs. Dog eats two bones, runs fast, barks loudly etc.
# Run the algorithms passing in these implementations created earlier.

# Summary
# Define Types and Behaviour. Create runtimes. Implement behaviours. Call runtimes passing in implementations of behaviours as arguments

