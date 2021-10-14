input = "ababcbacb";
% input = "The cat with that hat";
reconstructedInput = BWT(input);

disp(['Input:', input, 'Output:', reconstructedInput, 'Equal:', input == reconstructedInput]);

function reconstructedInput = BWT(input)
    word = strings(1, strlength(input));
    word(1, :) = num2cell(convertStringsToChars(input));
    
    B = createRotations(word);
    [lastCol, ind] = getResult(B, word);
    inverseB = reconstructB(lastCol);
    reconstructedInput = join(inverseB(ind, :), "");
end

function inverseB = reconstructB(y)
    originalY = y;

    for n = 2:length(originalY)
       y = strcat(originalY, sortrows(y));
    end
    y = sortrows(y);

    reconstructedB = strings(length(y), length(y));
    for n = 1:length(y)
        reconstructedB(n, :) = num2cell(convertStringsToChars(y(n)));
    end

    inverseB = reconstructedB;
end

function [y, L] = getResult(matrix, word)
    y = matrix(:, (end));
    L = find(ismember(matrix, word,'rows'));
end

function rotationMatrix = createRotations(word)
   wordMatrix = strings(length(word), length(word));
   wordMatrix(1, :) = word;

   for n = 2:length(word)
       wordMatrix(n, :) = circshift(wordMatrix(n - 1, :), -1);
   end

   rotationMatrix = sortrows(wordMatrix);
end
