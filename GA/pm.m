function mutated = pm(individual, mutation_prob, nm, lower_bound, upper_bound)
    % Polynomial Mutation
    % Inputs:
    %   individual: Vector of decision variables to be mutated
    %   mutation_prob: Probability of mutation for the entire vector
    %   nm: Distribution index for Polynomial Mutation
    %   lower_bound, upper_bound: Bounds for the decision variables

    % Number of decision variables
    D = length(individual);

    % Initialize the mutated individual
    mutated = individual;

    % Check if mutation occurs for the entire vector
    if rand() <= mutation_prob
        % Loop through each decision variable
        for i = 1:D
            % Generate a random beta value
            u = rand();
            if u < 0.5
                delta = (2 * u)^(1 / (nm + 1)) - 1;
            else
                delta = 1 - (2 * (1 - u))^(1 / (nm + 1));
            end

            % Apply mutation
            if rand() < 0.5
                mutated(i) = individual(i) + delta * (upper_bound(i) - individual(i));
            else
                mutated(i) = individual(i) - delta * (individual(i) - lower_bound(i));
            end

            % Bound the mutated values
            mutated(i) = min(max(mutated(i), lower_bound(i)), upper_bound(i));
        end
    end
end
