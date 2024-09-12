function [offspring1, offspring2] = SBX(parent1, parent2, pc, nc, lower_bound, upper_bound)
    % SBX: Simulated Binary Crossover
    % Inputs:
    %   parent1, parent2: Parent vectors
    %   pc: Crossover probability
    %   nc: Distribution index for SBX
    %   lower_bound, upper_bound: Bounds for the decision variables

    % Number of decision variables
    D = length(parent1);

    % Initialize offspring
    offspring1 = parent1;
    offspring2 = parent2;

    % Check if crossover should occur
    if rand() <= pc
        % Generate a uniform random number between 0 and 1
        u = rand(1, D);

        % Calculate beta values
        beta = zeros(1, D);
        beta(u <= 0.5) = (2 * u(u <= 0.5)).^(1 / (nc + 1));
        beta(u > 0.5) = (1 ./ (2 * (1 - u(u > 0.5)))).^(1 / (nc + 1));

        % Calculate offspring
        offspring1 = 0.5 * ((1 + beta) .* parent1 + (1 - beta) .* parent2);
        offspring2 = 0.5 * ((1 - beta) .* parent1 + (1 + beta) .* parent2);

        % Bound the offspring values
        offspring1 = min(max(offspring1, lower_bound), upper_bound);
        offspring2 = min(max(offspring2, lower_bound), upper_bound);
    end
end
