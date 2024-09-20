function [numerosOut, letrasOut] = cuentaLetrasNum(numeros, letras)
% cuentaLetrasNum 
% The cuentaLetrasNum function takes a vector of numbers (numeros) and a
% corresponding array of their word representations (letras), then starts
% at a random number between 1 and 99. It counts the number of letters in
% the word for that number, iteratively continues this process, and stops
% when the number of letters in a word is equal to the number itself or
% when it detects an alternating loop (to avoid infinite cycles like those
% between "cuatro" and "seis").
% 
% SYNTAX
% [numerosOut, letrasOut] = cuentaLetrasNum(numeros, letras)
% 
% INPUTS
% numeros: A vector of numbers from 1 to 99.
% letras: A string array of the word representations for the numbers in numeros.
% 
% OUTPUTS
% numerosOut: A vector of numbers representing the path traveled.
% letrasOut: A string array of the word representations of the numbers traveled.
% 
% Inspired by Matt Henderson's work, @matthen2
% https://blog.matthen.com/post/8554780863/pick-a-number-between-1-and-99-write-it-as-a
% _________________________________________________________________________
% Copyright (C) 2024 Edgar Guevara, PhD
% CONAHCYT-Universidad Autónoma de San Luis Potosí
% Coordinación para la Innovación y Aplicación de la Ciencia y la Tecnología
% _________________________________________________________________________
    close all
    % Initialize outputs
    numerosOut = [];
    letrasOut = [];
    
    % Randomly select a starting number between 1 and 99
    idx = randi(length(numeros));
    currentNum = numeros(idx);
    currentWord = letras(idx);
    disp(currentWord)

    % Variables to track the previous two numbers to detect loops
    prevNum = -1; 
    prevToPrevNum = -1; 
    
    % Loop until the length of the word is the same as the number
    % or it falls into a repeating loop
    while true
        % Append the current number and its word to the outputs
        numerosOut = [numerosOut, currentNum];
        letrasOut = [letrasOut, currentWord];
        
        % Count the number of letters in the current word
        numLetters = count(currentWord, lettersPattern(1));
        
        % Break if a loop occurs between two alternating numbers
        if currentNum == prevToPrevNum && numLetters == prevNum
            break;
        end
        
        % Update the history of previous numbers
        prevToPrevNum = prevNum;
        prevNum = currentNum;
        
        % Check if the number of letters is equal to the current number
        if numLetters == currentNum
            break;
        end
        
        % Update to the new number and its corresponding word
        currentNum = numLetters;
        idx = numeros == currentNum;
        currentWord = letras(idx);
        disp(currentWord)
    end
    % plots the directed graph , highlighting the travelled pathway
    plotDirectedGraphHighLight(numeros, letras, numerosOut)
end
