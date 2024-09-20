function plotDirectedGraphHighLight(numeros, letras, numerosOut)
% plotDirectedGraphHighLight
% 
% The plotDirectedGraphHighLight function visualizes all possible
% transitions between numbers (based on their word representations), as
% well as highlights a specific path traveled (given by numerosOut and
% letrasOut).
% 
% SYNTAX
% 
% plotDirectedGraphHighLight(numeros, letras, numerosOut, letrasOut)
% 
% INPUTS
% numeros: A vector of numbers from 1 to 99.
% letras: A string array of the word representations of the numbers.
% numerosOut: A vector representing the specific numbers traveled.
% letrasOut: A string array of the word representations for the traveled numbers.
% _________________________________________________________________________
% Copyright (C) 2024 Edgar Guevara, PhD
% CONAHCYT-Universidad Autónoma de San Luis Potosí
% Coordinación para la Innovación y Aplicación de la Ciencia y la Tecnología
% _________________________________________________________________________
    % Create a directed graph with nodes representing numbers from 1 to 99
    G = digraph(); % Initialize an empty directed graph
    
    % Build the graph by adding edges for each number in the 'numeros' array
    for i = 1:length(numeros)
        % Current number and its word representation
        currentNum = numeros(i);
        currentWord = letras(i);
        
        % Count the number of letters in the current word
        numLetters = count(currentWord, lettersPattern(1));
        
        % Add an edge, including self-loops (where number == numLetters)
        G = addedge(G, currentNum, numLetters);
    end
    
    % Create a new figure and maximize it
    figure('Units', 'normalized', 'OuterPosition', [0 0 1 1], 'color', 'w');

    % Plot the directed graph
    p = plot(G, 'Layout', 'force', 'NodeLabel', numeros, 'ArrowSize', 10);
    
    
    % Find the edges that were traveled (based on numerosOut)
    traveledEdges = [];
    for j = 1:length(numerosOut)-1
        % Get start and end nodes for each traveled step
        startNode = numerosOut(j);
        endNode = numerosOut(j+1);
        
        % Find the corresponding edge in the graph
        edgeIdx = findedge(G, startNode, endNode);
        
        if edgeIdx > 0
            traveledEdges = [traveledEdges; edgeIdx];
        end
    end
    
    % Highlight the edges representing the traveled pathway in red
    highlight(p, 'Edges', traveledEdges, 'EdgeColor', 'red', 'LineWidth', 2);

    if any(ismember(numerosOut, 5))
        % Find and highlight the self-loops (edges where source == target)
        loopEdges = find(G.Edges.EndNodes(:,1) == G.Edges.EndNodes(:,2));
        % Highlight the edges representing loops in red
        highlight(p, 'Edges', loopEdges, 'EdgeColor', 'red', 'LineWidth', 2);
    end
    % Increase font size of the node labels
    p.NodeFontSize = 12;  % You can change '12' to any desired font size
    
    % Add title and labels
    title('Directed Graph of Number Pathways Highlighted in Red');
    xlabel('Nodes represent numbers');
    ylabel('Edges represent transitions');
    set(gca, 'FontSize', 12)
end
