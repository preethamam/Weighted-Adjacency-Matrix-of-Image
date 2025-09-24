clc; close all; clear;

% Inputs
h = 6; w = 6;                       % Image size [height x width]
edgeDirection = 2;                  % Edge direction 1 - uni | 2 - bi
noded = 8;                          % Nodes 4-noded, 6-direction, 8-noded (pixels)
weight_type = 'Dissimilarity';      % Average (E(i), E(j)) / 2 
                                    % Similarity (E(i) - E(j)) 
                                    % Dissimilarity 1 / (E(i) - E(j)).
                                    % Where E is the energy at node i, j.
flowDirection = 'row_wise';         % 'row_wise' | 'col_wise'
useMATLABDefaultGplot = 0;          % Use MATLAB's dafult graph plotting with spring
graphType = 2;                      % '1 - undirected' (node = 4, 8) | '2 - directed' (node = 6)

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

% permutation that converts column-major (MATLAB default) -> row-major
perm = reshape(1:h*w, h, w).';   % transpose swaps the walk order
perm = perm(:);

% build the graph from the permuted adjacency
switch graphType
    case 1, G = graph(adjWeights, 'upper', 'OmitSelfLoops');
    case 2, G = digraph(adjWeights);
end

% grid coordinates (column-major first, then apply same permutation)
[row, col] = ind2sub([h w], 1:h*w);
X = col;                   % 1..w left→right
Y = h - row + 1;           % top→bottom
X = X(perm);  Y = Y(perm);     % <-- keep XY consistent with node order

% Plot the graph
figure; 
if noded == 6
    if useMATLABDefaultGplot == 1
        gp = plot(G);
    else
        % draw with fixed positions
        gp = plot(G, 'XData', X, 'YData', Y);                
    end
    axis equal;           % keep squares as squares
    axis tight;
    set(gca, 'YDir','normal');   % or: axis ij  (whichever you prefer)
    set(gca,'XTick',[], 'YTick', [])

    gp.Marker = 's';    
    gp.NodeColor = 'r';
    gp.MarkerSize = 7;
    gp.EdgeColor = 'b';
    gp.LineWidth = 1;
    gp.NodeFontSize = 12;
    gp.NodeFontWeight = "bold";
    if graphType == 2    
        gp.ArrowSize = 8;
    end

else
    if useMATLABDefaultGplot == 1
        gp = plot(G,'Layout','force');
    else
        % draw with fixed positions
        gp = plot(G, 'XData', X, 'YData', Y);
    end

    axis equal;           % keep squares as squares
    axis tight;
    set(gca, 'YDir','normal');   % or: axis ij  (whichever you prefer)
    set(gca,'XTick',[], 'YTick', [])

    gp.Marker = 's';    
    gp.NodeColor = 'r';
    gp.MarkerSize = 7;
    gp.EdgeColor = 'b';
    gp.LineWidth = 1;    
    gp.NodeFontSize = 12;
    gp.NodeFontWeight = "bold";
    if graphType == 2    
        gp.ArrowSize = 8;
    end
end

ax = gca;
exportgraphics(ax,'assets/fig_8noded_2.png')