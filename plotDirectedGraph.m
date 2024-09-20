function plotDirectedGraph(numeros, letras)
% plotDirectedGraph
% The plotDirectedGraph function builds and plots a directed graph where
% the nodes represent numbers from 1 to 99, and the edges represent
% transitions between numbers based on the number of letters in the word
% representing each number.
% 
% SYNTAX
% plotDirectedGraph(numeros, letras)
% 
% INPUTS
% numeros: A vector of numbers from 1 to 99.
% letras: A string array containing the word representations of the numbers.
% _________________________________________________________________________
% Copyright (C) 2024 Edgar Guevara, PhD
% CONAHCYT-Universidad Autónoma de San Luis Potosí
% Coordinación para la Innovación y Aplicación de la Ciencia y la Tecnología
% _________________________________________________________________________
    % Create a directed graph with nodes representing numbers from 1 to 99
    G = digraph(); % Initialize an empty directed graph
    
    % Loop over all numbers and their corresponding words
    for i = 1:length(numeros)
        % Current number and its word representation
        currentNum = numeros(i);
        currentWord = letras(i);
        
        % Count the number of letters in the current word
        numLetters = count(currentWord, lettersPattern(1));
        
        % Add an edge, including self-loops (where number == numLetters)
        G = addedge(G, currentNum, numLetters);
    end
    
    % Plot the directed graph
    figure;
    p = plot(G, 'Layout', 'force', 'NodeLabel', numeros, 'ArrowSize', 10);
    
    % Find and highlight the self-loops (edges where source == target)
    loopEdges = find(G.Edges.EndNodes(:,1) == G.Edges.EndNodes(:,2));
    
    % Highlight the edges representing loops in red
    highlight(p, 'Edges', loopEdges, 'EdgeColor', 'red');
    
    % Add title and labels
    title('Directed Graph of Number Pathways with Loops');
    xlabel('Nodes represent numbers');
    ylabel('Edges represent transitions');
end
