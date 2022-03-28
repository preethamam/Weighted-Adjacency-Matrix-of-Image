function adjWeights = computeWeightsAdjMat(adj,energy,weight_type,edgeDirection)

%%***********************************************************************%
%*                        Weighted adjacency matrix                     *%
%*                Computes the weighted adjacency matrix                *%
%*                                                                      *%
%*                                                                      *%
%* Author: Preetham Manjunatha                                          *%
%* Github link: https://github.com/preethamam                           *%
%* Date: 03/28/2022                                                     *%
%************************************************************************%
%
%************************************************************************%
%
% Usage: adjWeights              = computeWeightsAdjMat(adj,energy,weight_type,edgeDirection)
%        [___]                   = computeWeightsAdjMat(___, weight_type,edgeDirection)  
% Inputs:
%
%           adj                 - Adjacency matrix
%           energy              - Energy matrix (E)
%           weight_type         - Average (E(i), E(j)) / 2 
%                                 Similarity (E(i) - E(j)) 
%                                 Dissimilarity 1 / (E(i) - E(j)).
%                                 Where E is the energy at node i, j.
%           edgeDirection       - Edge direction 1 - uni | 2 - bi
%                                 
%
%
% 
% Outputs: 
%
%           adjWeights          - Weighted adjacency matrix
% 
%
%--------------------------------------------------------------------------
% Example 1: Similarity weights
% adj = adjacencyMatrix;
% energy = energyMatrix;
% weight_type = 'Similarity';
% edgeDirection = 2;
% adjWeights = computeWeightsAdjMat(adj,energy,weight_type,edgeDirection);
%
% Example 2: Average weights
% adj = adjacencyMatrix;
% energy = energyMatrix;
% weight_type = 'Average';
% edgeDirection = 2;
% adjWeights = computeWeightsAdjMat(adj,energy,weight_type,edgeDirection);
%
% Example 3: Dissimilarity weights
% adj = adjacencyMatrix;
% energy = energyMatrix;
% weight_type = 'Dissimilarity';
% edgeDirection = 2;
% adjWeights = computeWeightsAdjMat(adj,energy,weight_type,edgeDirection);


%------------------------------------------------------------------------------------------------------------------------
% nargin check
if nargin < 2
    error('Not enough input arguments.');
elseif nargin > 4
    error('Too many input arguments.');
end

if nargin == 2
    %-----------------------
    % Weight type
    weight_type = 'Similarity';

    % Edge direction
    edgeDirection = 2;
end

if nargin == 3
    %-----------------------
    % Edge direction
    edgeDirection = 2;
end

%------------------------------------------------------------------------------------------------------------------------
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


    
