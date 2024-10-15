function mating_pool = tournamentSelection(population, fitness, tournament_size)
    % population: matrix of individuals
    % fitness: vector of fitness values (lower is better)
    % tournament_size: size of the tournament
    
    num_individuals = size(population, 1); % Number of individuals in the population
    mating_pool = []; % Initialize mating pool
    
    for i = 1:num_individuals
        % Randomly select 'tournament_size' individuals from the population
        competitors = randi([1, num_individuals], tournament_size, 1);
        
        % Find the individual with the lowest fitness among competitors (minimization)
        [~, best_idx] = min(fitness(competitors));
        best_individual = population(competitors(best_idx), :);
        
        % Add the best individual to the mating pool
        mating_pool = [mating_pool; best_individual];
    end
    
    % % Now ensure that the best individual (lowest fitness) gets an extra copy
    % [~, best_overall_idx] = min(fitness); % Minimization selects the minimum fitness
    % best_overall_individual = population(best_overall_idx, :);
    % 
    % % Add the best individual once more
    % mating_pool = [mating_pool; best_overall_individual];
    % 
    % % Ensure that the worst individual (highest fitness) does not appear in the mating pool
    % [~, worst_idx] = max(fitness); % For minimization, the worst has the highest fitness
    % worst_individual = population(worst_idx, :);
    % 
    % % Remove any copies of the worst individual from the mating pool
    % matching_rows = ismember(mating_pool, worst_individual, 'rows');
    % mating_pool(matching_rows, :) = []; % Remove worst individual's copies
    
    % Create a new array containing only the required number of members from mating_pool
    if size(mating_pool, 1) > num_individuals
        selected_mating_pool = mating_pool(1:num_individuals, :); % Keep only the first 'num_individuals'
    else
        selected_mating_pool = mating_pool; % If already within limits, keep as is
    end
    mating_pool = selected_mating_pool;
end
