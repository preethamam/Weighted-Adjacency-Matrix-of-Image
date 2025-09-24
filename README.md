# Weighted adjacency matrix of an image
[![View Weighted adjacency matrix of an image using energy function on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/108934-weighted-adjacency-matrix-of-an-image-using-energy-function) [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=preethamam/Weighted-Adjacency-Matrix-of-Image)

Creates a weighted adjacency matrix from a energy matrix (E) for an image. Average, similarity and dissimilarity between the nodes i,j can be computed. If a custom energy matrix is provided, the same functions can be used to fill the adjacency matrix with edge weights.

# Graphs table
| Type | Images |
| --- | --- |
| 4-noded unidirection | ![fig_4noded_1](assets/fig_4noded_1.png) |
| 4-noded bidirection | ![fig_4noded_2](assets/fig_4noded_2.png) |
| 8-noded, six edges, vertical and cross directions | ![fig_6noded_shortpath](assets/fig_6noded_1.png) |
| 8-noded, eight edges, unidirection | ![fig_8noded_1](assets/fig_8noded_1.png) |
| 8-noded, eight edges, bidirection | ![fig_8noded_2](assets/fig_8noded_2.png) |

# Requirements
MATLAB <br />

# Run command
Please use the `demo.m` to run the program.

Change the hyper parameters accordingly if needed.
```
% Inputs
h = 3; w = 6;                       % Image size [height x width]
edgeDirection = 1;                  % Edge direction 1 - uni | 2 - bi
noded = 8;                          % Nodes 4-noded, 6-direction, 8-noded (pixels)
weight_type = 'Average';            % Average (E(i), E(j)) / 2 
                                    % Similarity (E(i) - E(j)) 
                                    % Dissimilarity 1 / (E(i) - E(j)).
                                    % Where E is the energy at node i, j.
flowDirection = 'col_wise';         % 'row_wise' | 'col_wise'
```


# Known issues
1. Sometimes `plot(G)` or `plot(G,'Layout','force')` produces strange looking graphs.

# Adaptation of open source 
Some of the MATLAB adjacency functions are adapted from the [Stack Overflow](https://stackoverflow.com/questions/3277541/construct-adjacency-matrix-in-matlab).

# Feedback
Please rate and provide feedback for the further improvements.

