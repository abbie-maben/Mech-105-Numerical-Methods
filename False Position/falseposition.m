function [root, fx, ea, iter] = falseposition(func, xl, xu, es, maxiter)
% This function will find the approximate the values of the roots of a
% function ustion the false position method. The function will display all
% of the outputs in the command window after the function has been
% evaluated.
% Inputs: func - the function being evaluated 
% xl- the lower guess, xu- the upper guess 
% es - the desired relative error (defaults to 0.0001%)
% maxiter - the number of iterations desired (defaults to 200)
% Outputs: root - the estimated root location
% fx - the function evaluated at the root location
% ea - the approximate relative error (%)
% iter- number of iterations performed
if nargin<3 % checks the number of inputs the user enters
    error (' There must be at least three inputs')
elseif nargin==3
    es=0.0001;
    maxiter=200;
elseif nargin==4
    maxiter=200;
end
if sign(func(xl)) ~= sign(func(xu)) % Checks the sign of the function
    root=xu-(func(xu)*(xl-xu)/(func(xl)-func(xu))); % Approximates the roots using the false position formula
    if func(root)==0 % On the off chance that the user gets the root on the first try
        fprintf('Yay you found the root!')
    end
else
    error('There is no sign change and no root go back and pick new xl and xu') 
    % Indicates that there is no roots in the brackets the user selected
end
iter=1;
ea=100;
while ea>es && iter<maxiter % Runs the loop until the max iterations is met or the error is less than required
    if sign(func(root))~=  sign(func(xu))
        xl=root; % Redefines the lower bracket to the previous root
        root=xu-(func(xu)*(xl-xu)/(func(xl)-func(xu)));
        ea=abs((root-xl)/root)*100; % Calculates the relative approximation error
    else
        xu=root; % Redefines the upper bracket to the previous root
        root=xu-(func(xu)*(xl-xu)/(func(xl)-func(xu)));
        ea=abs((root-xu)/root)*100;
    end
    iter=iter+1; % Counts the number of iterations
end
fx=func(root);
root=double(root); % Converts answers to decimal form
ea=double(ea);
fx=double(fx);
display(iter)
display(ea)
display(fx)
display(root)
end

