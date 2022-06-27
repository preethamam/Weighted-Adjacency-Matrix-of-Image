clc; close all; clear;

% Inputs
h = 3; w = 6;                       % Image size [height x width]
edgeDirection = 2;                  % Edge direction 1 - uni | 2 - bi
noded = 8;                          % Nodes 4-noded, 6-direction, 8-noded (pixels)
weight_type = 'Similarity';         % Average (E(i), E(j)) / 2 
                                    % Similarity (E(i) - E(j)) 
                                    % Dissimilarity 1 / (E(i) - E(j)).
                                    % Where E is the energy at node i, j.
flowDirection = 'col_wise';         % 'row_wise' | 'col_wise'
% Examples
% edgeDirection = 1;
% noded = 4;
% flowDirection = 'col_wise';
% 
% edgeDirection = 2;
% noded = 4;
% flowDirection = 'col_wise';
% 
% edgeDirection = 1;
% noded = 6;  % direction
% flowDirection = 'row_wise';
% 
% edgeDirection = 2;
% noded = 6;  % direction
% flowDirection = 'row_wise';
% 
% edgeDirection = 1;
% noded = 8;
% flowDirection = 'row_wise';
% 
% edgeDirection = 2;
% noded = 8;
% flowDirection = 'row_wise';

% Image size [height x width]
imSize = [h w];

% Random image
rng(1)
if (rand(1) > 0.5)
    Im = randn(imSize);
else
    Im = rand(imSize);
end

% Energy of all pixels
energy = abs(imfilter(Im, [-1,0,1], 'replicate')) + abs(imfilter(Im, [-1;0;1], 'replicate'));

% Get adjacency matrix
adj = getAdjacenyMatrix468noded(imSize,edgeDirection,noded, flowDirection);

% Compute weights at nodes i,j and fill the adjacency matrix
adjWeights = computeWeightsAdjMat(adj,energy,weight_type,edgeDirection);

% Create directed graph
G = digraph(adjWeights);

% Plot the graph
figure; 
if noded == 6
    gp = plot(G);
else
    gp = plot(G,'Layout','force');
end
