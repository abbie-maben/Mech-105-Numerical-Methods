# falseposition.m
This function will find the approximate the values of the roots of a function using the false position method. The function will display all of the outputs in the command window after the function has been evaluated.
## Inputs
+ xl- Lower guess of location of the root
+ xu- Upper guess of location of the root
+ es- Desired percent relative error (defaults to 0.0001%)
+ maxiter- The number of iterations desired (defaults to 200)
## Outputs
+ root- The estimated value of the root
+ fx- The function evaluated at the estimated root
+ ea- The percent approximate relative error
+ iter- The number of iterations performed