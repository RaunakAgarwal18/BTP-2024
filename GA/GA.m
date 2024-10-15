function [Best_score, Best_pos, GA_curve] = GA(SearchAgents, Max_iterations, lowerbound, upperbound, dimension, fitness)
    % Parameters:
    % SearchAgents: Number of individuals in the population
    % Max_iterations: Number of generations
    % lowerbound, upperbound: Boundaries for the decision variables
    % dimension: Number of decision variables
    % fitness: Handle to the fitness function (to be minimized)

    % Hyperparameters
    pc = 0.8;   % Probability of crossover
    pmm = 0.1;    % Probability of mutation
    tournament_size = 2;    % Size of tournament for selection
    nc = 2;                 % SBX crossover distribution index (can adjust)
    nm = 2;                 % Polynomial mutation distribution index (can adjust)

    % Initialize the population randomly within bounds
    population = lowerbound + (upperbound - lowerbound) .* rand(SearchAgents, dimension);
    GA_curve = zeros(1, Max_iterations);  % Store best fitness over generations

    % Evaluate initial fitness of the population
    fitness_values = zeros(SearchAgents, 1);
    for i = 1:SearchAgents
        fitness_values(i) = fitness(population(i, :));
    end
    
    % Initialize best solution
    [Best_score, best_idx] = min(fitness_values);
    Best_pos = population(best_idx, :);

    % Start the GA evolution process
    for iter = 1:Max_iterations
        % Selection (using tournament selection)
        mating_pool = tournamentSelection(population, fitness_values, tournament_size);
        
        % Crossover and mutation to create new population
        new_population = [];
        for i = 1:2:SearchAgents
            if i+1 <= SearchAgents
                parent1 = mating_pool(i, :);
                parent2 = mating_pool(i+1, :);
    
                % Perform SBX Crossover
                [child1, child2] = SBX(parent1, parent2, pc, nc, lowerbound, upperbound);  % Crossover probability 0.8, nc = 10
                new_population = [new_population; child1; child2];
            end
        end
    
        % Apply Polynomial Mutation to offspring
        mutated_offspring = zeros(size(new_population));
        for i = 1:size(new_population, 1)
            mutated_offspring(i, :) = pm(new_population(i, :), pmm, nm, lowerbound, upperbound);  % Mutation probability 0.3, nm = 20
        end
        
        
        % Ensure new population doesn't exceed SearchAgents
        new_population = new_population(1:SearchAgents, :);
        
        % Evaluate the fitness of the new population
        for i = 1:SearchAgents
            fitness_values(i) = fitness(new_population(i, :));
        end
        
        % Update the population
        population = new_population;
        
        % Track the best solution found so far
        [current_best_score, best_idx] = min(fitness_values);
        if current_best_score < Best_score
            Best_score = current_best_score;
            Best_pos = population(best_idx, :);
        end
        
        % Store the best score of this iteration
        GA_curve(iter) = Best_score;
    end
end


% for i = 1:2:SearchAgents
        %     parent1 = mating_pool(i, :);
        %     parent2 = mating_pool(i+1, :);
        % 
        %     % Crossover (SBX)
        %     if rand < crossover_rate
        %         [offspring1, offspring2] = SBX(parent1, parent2, crossover_rate, nc, lowerbound, upperbound);
        %     else
        %         offspring1 = parent1;
        %         offspring2 = parent2;
        %     end
        % 
        %     % Mutation (Polynomial mutation)
        %     offspring1 = pm(offspring1, mutation_prob, nm, lowerbound, upperbound);
        %     offspring2 = pm(offspring2, mutation_prob, nm, lowerbound, upperbound);
        % 
        %     % Add offspring to the new population
        %     new_population = [new_population; offspring1; offspring2];
        % end