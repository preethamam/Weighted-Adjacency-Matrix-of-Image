function adjWeights = computeWeightsAdjMat(edgeDirection, weight_type, adj, energy)

% Find the upper traiangular rows and columns indices
[row, col] = find(triu(adj));

% Flatten the energy values
energyFlat = reshape(energy',1,[]);

% Find the edge weights
switch weight_type
    case "Average"
        weights = (energyFlat(row) + energyFlat(col)) ./ 2;
    case "Similarity"
        weights = abs(energyFlat(row) - energyFlat(col));    
    case "Dissimilarity"
        weights = 1 ./ abs(energyFlat(row) - energyFlat(col));
end
weights = weights';

% Find the linear indices 
ind = sub2ind(size(adj),row,col);

% Find the upper traiangular elements
adjCopyUpperTri = triu(adj);

% Fill the edge weights to the upper trianhular adjacency matirx
adjCopyUpperTri(ind) = weights;

% Depending on the nodes, fill and get final adjacency edge weights
adjWeights = adjCopyUpperTri;

% Adjacency matrix
if edgeDirection == 2
    adjWeights = adjWeights + adjWeights.';                           % Add the matrix to a transposed copy of
end                                                                   % itself to make it symmetric

end


    
