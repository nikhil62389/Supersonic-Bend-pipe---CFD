clear all
close all
clc

%% Defining the mesh using the n points, domain size usually give as 
n_point = 5;
dom_size = 1;
h = dom_size / (n_point - 1);

%% Initializing the problem as the indexing starts from 1 to 5 where first 0 is the given to all the points in between the boundary conditions.
y(1) = 0;
y(n_point) = 1;

ynew(1) = 0;
ynew(n_point) = 1;

error_mag = 1;
error_req = 1e-7;
iterations = 0;

%% calculations
while error_mag > error_req
    for i = 2:(n_point-1)
        ynew(i) = 0.5.*(y(i-1) + y(i+1));
    end
    iterations = iterations + 1;
    % Calculation of error
    error_mag = 0;
    for i = 2:(n_point-1)
        error_mag = error_mag + abs(y(i) - ynew(i));
    end

    % Assigning new to old
    y = ynew;
end


%% PLotting
x_dom = ((1 : n_point)-1).*h;
figure;plot(x_dom,y)


 