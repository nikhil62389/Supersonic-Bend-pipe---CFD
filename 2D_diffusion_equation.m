clear all
close all
clc

%% Defining the mesh using n points in both direction

n_point = 51;
dom_size = 1;
h = (dom_size / (n_point - 1));

%% Intialising the problem on both the axis using i and j
y(n_point,n_point) = 0;
y(1,:) = 1;

ynew(n_point,n_point) = 0;
ynew(1,:) = 1;

error_mag = 1;
error_req = 1e-6;
iterations = 0;

%% Calculation
while error_mag > error_req
    for i = 2:(n_point - 1)
        for j = 2:(n_point - 1)
            ynew(i,j) = 0.25.*(ynew(i-1,j) + y(i,j+1) + ynew(i,j-1) + y(i+1,j));
        end
    end
    iterations = iterations + 1;
    % Calculation of error
    error_mag = 0;
    for i = 2:(n_point - 1)
        for j = 2:(n_point - 1) 
    error_mag = error_mag + abs(y(i,j) - ynew(i,j));
        end
    end
    % assigning new to old
    y = ynew;
end

%% PLotting
x_dom = ((1 : n_point)-1).*h;
y_dom = 1-((1:n_point)-1).*h;
[X,Y] = meshgrid(x_dom,y_dom);
contourf(X,Y,y, 12)
colorbar