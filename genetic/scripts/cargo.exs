defmodule Cargo do
	@behaviour Problem
	alias Types.Chromosome

	@impl true
	def genotype do
		genes = for _ <- 1..10, do: Enum.random(0..1)
		%Chromosome{genes: genes, size: 10}
	end

	@impl true
	def fitness_function(chromosome) do
		weights = [10, 6, 8, 7, 10, 9, 7, 11, 6, 8] # set of weights
		profits = [6, 5, 8, 9, 6, 7, 3, 1, 2, 6] # set of corresponding profits
		weight_limit = 40 # weight constraint

		potential_profits = 
			chromosome.genes
			|> Enum.zip(profits) # corresponding elements of gene (0 or 1 based on randomization) mapped to profit for that element.
			|> Enum.map(fn {c, p} -> c * p end) # multiply the profit by corresponding element of the gene
			|> Enum.sum() # get the profit total for the gene

		over_limit? = 
			chromosome.genes
			|> Enum.zip(weights) # corresponding elements of gene mapped to weight for that element
			|> Enum.map(fn {c, w} -> c * w end) # multiply the weight by corresponding element of the gene
			|> Enum.sum() # get the weight total for the gene
			|> Kernel.>(weight_limit) # check if it exceeds the weight limit

		profits = if over_limit?, do: 0, else: potential_profits # profits are applicable only if they are not over limit.
		profits

#		profits
#		|> Enum.zip(chromosome.genes) # take corresponding elements from two lists and group them into tuples
#		|> Enum.map(fn {p, g} -> p * g end) # multiply the profit for each cargo included in the current gene
#		|> Enum.sum() # sum to get total profit
	end

	@impl true
	def terminate?(population) do
		Enum.max_by(population, &Cargo.fitness_function/1).fitness == 53
	end
end

soln = Genetic.run(Cargo, population_size: 50)
IO.write("\n")
IO.inspect(soln)

weight =
soln.genes
|> Enum.zip([10, 6, 8, 7, 10, 9, 7, 11, 6, 8])
|> Enum.map(fn {g, w} -> w*g end)
|> Enum.sum()

IO.write("\nWeight is: #{weight}\n")