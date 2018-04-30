function [t,y] = Huen(dydt,tspan,y0,h,es,maxit)
% Code by Abbie Maben 29 April 2018
% This function uses Huen's method with iteration to solve ordinary 
% differential equations given an initial value. The function utilizes 
% Euler's method for the slope at the beginning of the interval then uses a 
% predicted value that is corrected for error to estimate the slope at each 
% t on the interval. The function then takes the average of these two 
% slopes to predict the value of the function at t.
% INPUTS:
% dydt- the differential equation being solved for
% tspan- the interval over which the function is being performed
% y0- the initial condition
% h- step size
% es- approximate error for stopping criterion (defaults to 0.001)
% maxit- maximum iterations performed per value of t (defaults to 50)
% OUTPUTS:
% t- vector containing all of the values to t that were evaluated
% y- vector containing estimated values of the function for each t
if nargin<4 % checks to make sure the user inputs enough into the function
    error('Must have at least 4 inputs')
elseif nargin==5
    maxit=50; % defaults number of maximum iterations if user doesn't input
elseif nargin==4 
    maxit=50; % defaults both maximum iterations and relative error
    es=0.001;
end
numinterval=floor((tspan(2)-tspan(1))/h); % determines the number of 
% values that need to be found over the given interval with the step size
t=zeros(1,numinterval); % preallocates vector for t
y=zeros(1,numinterval);
t0=tspan(1); % sets inital t to the first value in the interval
t(1)=t0; % sets first value in t vector
y(1)=y0; % sets first value in y vector as initial condition given
iter=0; % initializes iterations performed
err=100; % initializes error
for i=1:numinterval
    slopeleft=dydt(t0,y0); % calculates the left slope with differential eq
    ypredict=y0+h*slopeleft; % predicts the new value of the function using Euler's method
    sloperight=dydt(t0+h,ypredict); % calculates slope right with new y value
    ycorrect=y0+(h/2)*(slopeleft+sloperight); % corrects the predicted value with the new calculated slopes
    while err>es && iter<maxit % runs until the stopping criteria is met
        ycorrectnew=y0+(h/2)*(slopeleft+dydt(t0+h,ycorrect)); % recalculates value of the function
        err=abs((ycorrectnew-ycorrect)/ycorrectnew*100); % calculates approximate error
        ycorrect=ycorrectnew; 
        iter=iter+1;
    end
    t(i+1)=t0+h; % stores each t value in the vector
    y(i+1)=ycorrect; % stores each y value in the vector
    y0=ycorrect; 
    t0=t0+h; % makes the loop move one step size forward
    iter=0; % resets iteration number
    err=100; % resets error
end
if numinterval~=(range(tspan)/h) % checks to see if the interval has any remainder value for the step size given
    t0=tspan(2); % sets t0 as the last value in the interval
    h=tspan(2)-numinterval*h; % recalculates the step size for the last interval
    slopeleft=dydt(t0,y0);
    ypredict=y0+h*slopeleft;
    sloperight=dydt(t0+h,ypredict);
    ycorrect=y0+(h/2)*(slopeleft+sloperight);
    while err>es && iter<maxit % reruns the same while loop for the last interval
        ycorrectnew=y0+(h/2)*(slopeleft+dydt(t0+h,ycorrect));
        err=abs((ycorrectnew-ycorrect)/ycorrectnew*100);
        ycorrect=ycorrectnew;
        iter=iter+1;
    end
    t(i+2)=t0;
    y(i+2)=ycorrect;
end
plot(t,y,'gd-') % plots the resulting vectors t and y
end

