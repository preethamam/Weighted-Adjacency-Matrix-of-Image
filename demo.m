clc; close all; clear;

% Inputs
h = 3; w = 6;                       % Image size [height x width]
edgeDirection = 1;                  % Edge direction 1 - uni | 2 - bi
noded = 8;                          % Nodes 4-noded, 6-direction, 8-noded (pixels)
weight_type = 'Average';            % Average (E(i), E(j)) / 2 
                                    % Similarity (E(i) - E(j)) 
                                    % Dissimilarity 1 / (E(i) - E(j)).
                                    % Where E is the energy at node i, j.

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
adj = getAdjacenyMatrix468noded(edgeDirection,imSize,noded);

% Compute weights at nodes i,j and fill the adjacency matrix
adjWeights = computeWeightsAdjMat(edgeDirection,weight_type, adj, energy);

% Create directed graph
G = digraph(adjWeights);

% Plot the graph
figure; 
if noded == 6
    gp = plot(G);
else
    gp = plot(G,'Layout','force');
end