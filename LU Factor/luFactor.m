function [L,U,P] = luFactor(A)
% 25 March 2018 Code by: Abbie Maben
% This function determines the LU factorization of any square matrix using
% partial pivoting and Gauss elimination. The function takes in a matrix
% with the coefficients of the system of equations and outputs the lower
% triangular matrix, upper triangular matrix and pivot matrix.
% Inputs: A - coefficient matrix
% Outputs: L - lower triangular matrix
% U - upper triangular matrix
% P - the pivot matrix
[r,c]=size(A); % r=rows of matrix c=columns of matrix
if r==1
    error('The matrix must be larger than a 1x1')
end
if r~=c
    error('The matrix must have sqaure dimensions')
end
P=eye(r); % creates an identity matrix with the same dimensions as A
U=A; % sets the upper triangular matrix as A
L=eye(r); % presets the lower triangular matrix
for i=1:r % runs the loop through all of the rows
    maxelement=max(abs(A(i:r,i))); % finds the element with the largest absolute value
        for j=i:r % runs the loop until the row with the max element is found
            if(abs(U(j,i)))== maxelement 
            % finds the location of the row with the max element
            row=j; % sets the location of the max element equal to the variable row
            end
        end
    P([i,row],:)=P([row,i],:); % switches the rows in pivot matrix
    U([i,row],i:r)=U([row,i],i:r); % switches rows in upper triangular matrix
    L([i,row],1:i-1)=L([row,i],1:i-1); % pivots element-by-element for the lower triangular matrix
    for j=i+1:r % runs the loop for all rows but j is one row further than i
        ratio = U(j,i)/U(i,i); % the ratio needed to perform Gauss elimination
        U(j,i:r)=U(j,i:r)-(U(i,i:r)*ratio); % performs elimination by subtracting the coefficients
        L(j,i)=ratio; % places the ratio in the lower triangular matrix
    end
end

display(P) % displays the P, U, and L matrices
display(U)
display(L)
end