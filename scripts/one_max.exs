population = for _ <- 1..100, do: for _ <- 1..1000, do: Enum.random(0..1)

# evaluate, selection, crossover and algorithm are anonymous functions.

evaluate = 
	fn population -> 
			# population is a list of lists [[1,1,0,0,1...1,1,0],[1,1,1,0,0...0,1,1]] 100 lists, 1000 bits each
		Enum.sort_by(population, &Enum.sum/1, &>=/2) 
			# sort the list of lists by sum of bits so lists with higher number of one's are at the top. Mapper sums each row. Sorter is descending &>=/2
			# note the use of anonymous functions defined by &.
end

selection = 
	fn population -> 
			# population is a list of lists [[1,1,0,0,1...1,1,0],[1,1,1,0,0...0,1,1]] 100 lists, 1000 bits each
		Enum.chunk_every(population, 2)
			# chunk into sets of 2 [[[1,1,0,0,1...1,1,1],[1,1,1,1,0...1,1,1]],[[1,1,0,0,0...0,1,1],[1,1,1,1,1...1,1,0]]]
		|> Enum.map(&List.to_tuple(&1)) # convert to tuples because it is needed for the next step
			# convert to a list of tuples of lists [{[1,1,0,0,1...1,1,1],[1,1,1,1,0...1.1.1]},{[1,1,0,0,0...0,1,1],[1,1,1,1,1...1,1,0]}]
	end

crossover = 
	fn population -> 
			#population is a list of tuples of lists [{[1,1,0,0,1...1,1,1],[1,1,1,1,0...1.1.1]},{[1,1,0,0,0...0,1,1],[1,1,1,1,1...1,1,0]}]
		Enum.reduce(population, [],
			fn {p1, p2}, acc -> # {p1, p2} corresponds to {[1,1,0,0,1],[1,1,1,1,0]} so p1 = [1,1,0,0,1] and p2 = [1,1,1,1,0]
				cx_point = :rand.uniform(1000)
				{{h1, t1}, {h2, t2}} = {Enum.split(p1, cx_point), Enum.split(p2, cx_point)}
						# p1 = [1,1,0,0,1] gets split into two lists one 0 to cx_point, other cx_point to end {[1,1,1,0],[1,0,1,1]}
						# p2 = [1,1,0,0,1] gets split into two lists one 0 to cx_point, other cx_point to end {[1,0,1,1],[1,0,0,1]}
						# and the result combined to a tuple so you end up with 
						# {{[1,1,1,0],[1,0,1,1]}, {[1,0,1,1],[1,0,0,1]}} so h1 = [1,1,1,0], t1 = [1,0,1,1], h2 = [1,0,1,1], t2 = [1,0,0,1]
				[h1 ++ t2, h2 ++ t1 | acc]
					# list h1 is appended to t2 and list h2 is appended to t1 giving two list. These lists are added to the accumulator. So accumulator is eventually and list of lists, similar to the original population
			end
		)
	end

mutation = 
	fn population ->
		Enum.map(population, fn chromosome -> 
			if :rand.uniform() < 0.05 do
				Enum.shuffle(chromosome)
			else
				chromosome
			end
		end)
	end

algorithm = 
	fn population, algorithm ->
		best = Enum.max_by(population, &Enum.sum/1)
		IO.write("\rCurrent Best: " <> Integer.to_string(Enum.sum(best)))
		if Enum.sum(best) == 1000 do
			best
		else 
			population
			|> evaluate.()
			|> selection.()
			|> crossover.()
			|> mutation.()
			|> algorithm.(algorithm)
		end
	end

solution = algorithm.(population, algorithm)
IO.write("\n Answer is \n")
IO.inspect solution