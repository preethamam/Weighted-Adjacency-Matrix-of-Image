function adj = getAdjacenyMatrix468noded(edgeDirection, imSize, node)

r = imSize(1); c = imSize(2);                          % Get the matrix size

switch node
    case 4 % (4 direction -- Directed (a)cyclic Graph - uni/bidirection)
        diagVec1 = sparse(repmat([ones(c-1, 1); 0], r, 1));  % Make the first diagonal vector
                                                     %   (for horizontal connections)
        diagVec1 = sparse(diagVec1(1:end-1));                % Remove the last value
        diagVec2 = sparse(ones(c*(r-1), 1));                 % Make the second diagonal vector
                                                     %   (for vertical connections)
        adj = diag(diagVec1, 1)+diag(diagVec2, c);   % Add the diagonals to a zero matrix        

    case 6 % (6 direction -- Directed (a)cyclic Graph - uni/bidirection)
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

    case 8 % (8 direction -- Directed (a)cyclic Graph - uni/bidirection)
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

end

% Adjacency matrix
if edgeDirection == 2
    adj = adj+adj.';                           % Add the matrix to a transposed copy of
end    

end