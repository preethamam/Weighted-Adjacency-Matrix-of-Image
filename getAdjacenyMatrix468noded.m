function adj = getAdjacenyMatrix468noded(imSize, edgeDirection, node, flowDirection)

%%***********************************************************************%
%*                        4-6-8 noded adjacency matrix                  *%
%*                Outputs an adjacency matrix with unit weights         *%
%*                given the image size.                                 *%
%*                                                                      *%
%* Author: Preetham Manjunatha                                          *%
%* Github link: https://github.com/preethamam                           *%
%* Date: 03/28/2022                                                     *%
%************************************************************************%
%
%************************************************************************%
%
% Usage: adj                     = getAdjacenyMatrix468noded(imSize, edgeDirection, node, flowDirection)
%        [___]                   = getAdjacenyMatrix468noded(___, edgeDirection, node, flowDirection)  
% Inputs:
%
%           imSize              - Image size [height x width] or [row x
%                                 columns]
%           edgeDirection       - Edge direction 1 - uni | 2 - bi
%           node                - 4 or 8 noded or 8-noded six directions
%           flowDirection       - 'row_wise' (row-by-row) | 'col_wise' (col-by-col)                     
% 
% Outputs: 
%
%           adj                 - Adjacency matrix
% 
%
%--------------------------------------------------------------------------
% Example 1: Similarity weights
% imSize = [256 512];
% edgeDirection = 2;
% node = 8;
% adj = getAdjacenyMatrix468noded(imSize, edgeDirection, node);
%
% Example 2: Average weights
% imSize = [256 512];
% edgeDirection = 1;
% node = 4;
% adj = getAdjacenyMatrix468noded(imSize, edgeDirection, node);
%
% Example 3: Dissimilarity weights
% imSize = [256 512];
% edgeDirection = 1;
% node = 6; % (8-noded, siz directions)
% adj = getAdjacenyMatrix468noded(imSize, edgeDirection, node);


%------------------------------------------------------------------------------------------------------------------------
% nargin check
if nargin < 1
    error('Not enough input arguments.');
elseif nargin > 4
    error('Too many input arguments.');
end

if nargin == 1
    %-----------------------
    % Edge direction
    edgeDirection =  2;

    % Pixel noded
    node = 8;
end

if nargin == 2
    %-----------------------
    % Pixel noded
    node = 8;
end


%------------------------------------------------------------------------------------------------------------------------
r = imSize(1); c = imSize(2);                          % Get the matrix size
switch node
    case 4 % (4 direction -- Directed (a)cyclic Graph - uni/bidirection)
        if strcmp(flowDirection,'row_wise')
            diagVec1 = sparse(repmat([ones(c-1, 1); 0], r, 1));  % Make the first diagonal vector
                                                         %   (for horizontal connections)
            diagVec1 = sparse(diagVec1(1:end-1));                % Remove the last value
            diagVec2 = sparse(ones(c*(r-1), 1));                 % Make the second diagonal vector
                                                         %   (for vertical connections)
            adj = diag(diagVec1, 1)+diag(diagVec2, c);   % Add the diagonals to a zero matrix     
        else
            diagVec1 = sparse(repmat([ones(r-1, 1); 0], c, 1));  % Make the first diagonal vector
                                                         %   (for horizontal connections)
            diagVec1 = sparse(diagVec1(1:end-1));                % Remove the last value
            diagVec2 = sparse(ones(r*(c-1), 1));                 % Make the second diagonal vector
                                                         %   (for vertical connections)
            adj = diag(diagVec1, 1)+diag(diagVec2, r);
        end

    case 6 % (6 direction -- Directed (a)cyclic Graph - uni/bidirection)
        if strcmp(flowDirection,'row_wise')
            diagVec1 = sparse(repmat([ones(c-1, 1); 0], r, 1));  % Make the first diagonal vector
                                                         %   (for horizontal connections)
            diagVec1 = sparse(diagVec1(1:end-1));                % Remove the last value
            diagVec2 = sparse([0; diagVec1(1:(c*(r-1)))]);       % Make the second diagonal vector
                                                         %   (for anti-diagonal connections)
            diagVec3 = sparse(ones(c*(r-1), 1));                 % Make the third diagonal vector
                                                         %   (for vertical connections)
            diagVec4 = sparse(diagVec2(2:end-1));                % Make the fourth diagonal vector
                                                         %   (for diagonal connections)
            % Adjacency matrix
            adj = diag(diagVec2, c-1)+...                % Add the diagonals to a zero matrix 
                  diag(diagVec3, c)+...                  
                  diag(diagVec4, c+1);  
        else
            diagVec1 = sparse(repmat([ones(r-1, 1); 0], c, 1));  % Make the first diagonal vector
                                                         %   (for horizontal connections)
            diagVec1 = sparse(diagVec1(1:end-1));                % Remove the last value
            diagVec2 = sparse([0; diagVec1(1:(r*(c-1)))]);       % Make the second diagonal vector
                                                         %   (for anti-diagonal connections)
            diagVec3 = sparse(ones(r*(c-1), 1));                 % Make the third diagonal vector
                                                         %   (for vertical connections)
            diagVec4 = sparse(diagVec2(2:end-1));                % Make the fourth diagonal vector
                                                         %   (for diagonal connections)
            % Adjacency matrix
            adj = diag(diagVec2, r-1)+...                % Add the diagonals to a zero matrix 
                  diag(diagVec3, r)+...                  
                  diag(diagVec4, r+1);  
        end

    case 8 % (8 direction -- Directed (a)cyclic Graph - uni/bidirection)
        if strcmp(flowDirection,'row_wise')
            diagVec1 = sparse(repmat([ones(c-1, 1); 0], r, 1));  % Make the first diagonal vector
                                                         %   (for horizontal connections)
            diagVec1 = sparse(diagVec1(1:end-1));                % Remove the last value
            diagVec2 = sparse([0; diagVec1(1:(c*(r-1)))]);       % Make the second diagonal vector
                                                         %   (for anti-diagonal connections)
            diagVec3 = sparse(ones(c*(r-1), 1));                 % Make the third diagonal vector
                                                         %   (for vertical connections)
            diagVec4 = sparse(diagVec2(2:end-1));                % Make the fourth diagonal vector
                                                         %   (for diagonal connections)
            adj = diag(diagVec1, 1)+...                  % Add the diagonals to a zero matrix
                  diag(diagVec2, c-1)+...
                  diag(diagVec3, c)+...
                  diag(diagVec4, c+1);
        else
            diagVec1 = sparse(repmat([ones(r-1, 1); 0], c, 1));  % Make the first diagonal vector
                                                         %   (for horizontal connections)
            diagVec1 = sparse(diagVec1(1:end-1));                % Remove the last value
            diagVec2 = sparse([0; diagVec1(1:(r*(c-1)))]);       % Make the second diagonal vector
                                                         %   (for anti-diagonal connections)
            diagVec3 = sparse(ones(r*(c-1), 1));                 % Make the third diagonal vector
                                                         %   (for vertical connections)
            diagVec4 = sparse(diagVec2(2:end-1));                % Make the fourth diagonal vector
                                                         %   (for diagonal connections)
            adj = diag(diagVec1, 1)+...                  % Add the diagonals to a zero matrix
                  diag(diagVec2, r-1)+...
                  diag(diagVec3, r)+...
                  diag(diagVec4, r+1);
        end

end

% Adjacency matrix
if edgeDirection == 2
    adj = adj+adj.';                           % Add the matrix to a transposed copy of
end    

end