function [I] = Simpson(x,y)
% Function created by Abbie Maben on 4 April 2018
% This function approximates the integral of points inputed in the form of
% vectors using the Simpson's 1/3 rule and the trapazoidal rule. The
% function uses the Simpson's 1/3 rule if the number of inputs is odd
% and if the number of inputs is even, the function will use the
% trapizoidal rule to approximate the last two inputs.
% INPUTS: x- vector with the values of the independent variable
%         y- vector with the values of the dependent variable with respect
%         to x
% OUTPUTS: I- The approximated value of the integral
if nargin<2 % checks the number of inputs for the function
    error('Must input two vectors')
elseif nargin>2
    error('Too many arguments entered')
end
[rowx,colx]=size(x); % finds the number of rows and columns in each vector
[rowy,coly]=size(y);
if rowx~=1 && colx~=1 % makes sure the input is a column or row vector
    error('must input a row or column vector')
elseif rowy~=1 && coly~=1
    error('must input a row or column vector')
end
if numel(x)~= numel(y) % check to see if inputs are the same dimensions
    error('The vectors must have the same number of inputs')
elseif numel(x)<3 % makes sure there are at least three inputs
    error('The vector must contain at least three inputs')
end
format short
A=diff(x); % finds the difference between two elements in the x vector
if range(A)>0.00000001 % makes sure the values of x are equally spaced
    error('Must have equally spaced intervals')
end
I=0; % presets variables I and T
T=0;
if mod(numel(x),2)==1 % checks if the number of inputs is even or odd
    for k=1:2:numel(x)-2 % runs the loop increasing the value of k by two
        % until two less than the total number of elements in the matrix
        I=((x(3)-x(1))*(y(k)+4*y(k+1)+y(k+2)))/6+I; % calculates the Simpsons 1/3 rule value of the inputs
    end
else % if the vector has an even number of inputs
    warning('trapazoidal rule was used to the last interval')
    for k=1:2:numel(x)-3
        I=((x(3)-x(1))/6)*(y(k)+4*y(k+1)+y(k+2))+I;
    end
    T=((x(2)-x(1))*(y(numel(x))+y(numel(x)-1))/2); 
    % calculates value of the integral with the trapaziodal rule for the
    % last two data points
    I=I+T; % sums together the value from the Simpsons 1/3 rule and the trapazoidal rule
end
end

