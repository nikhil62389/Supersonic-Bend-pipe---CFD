gclear all
close all
clc
%% Defining the mesh
n_point = 51;
dom_size = 1;
h = dom_size / (n_point - 1);
dt = 0.0001;
alpha = dt / (h*h);
%% Intialising the problem
y(n_point,n_point) = 0;
y(1,:) = 1;

ynew(n_point,n_point) = 0;
ynew(1,:) = 1;

error_mag = 1;
error_req = 1e-6;
iterations = 0;

% Tracking the error magnitude
error_track = 0;

%% Calculation
while error_mag > error_req
    for i = 2:(n_point - 1)
        for j = 2:(n_point - 1)
            ynew(i,j) = y(i,j) + alpha.*(y(i+1,j) + y(i-1,j) + y(i,j+1) + y(i,j-1) - 4*y(i,j));
        end
    end
    iterations = iterations + 1;
    % Calculation of the error magnitude
    error_mag = 0;
    for i = 2:(n_point - 1)
        for j = 2:(n_point - 1)
            error_mag = error_mag + abs(y(i,j) - ynew(i,j));
            error_track(iterations) = error_mag;
        end
    end
    if rem(iterations, 1000) == 0;
        iterations
        error_mag
    end

    %Assigning new to old
    y = ynew;
end
%% Plotting
x_dom = ((1 : n_point)-1).*h;
y_dom = 1-((1:n_point)-1).*h;
[X,Y] = meshgrid(x_dom,y_dom);
contourf(X,Y,y, 12)
colorbar
xlabel('x');
ylabel('y');
print(gcf,'Example_1.png','-dpng','-r300');
