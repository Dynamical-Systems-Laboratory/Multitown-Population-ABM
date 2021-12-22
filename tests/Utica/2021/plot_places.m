data = load('Ut_households.txt');
scatter(data(:,3), data(:,2), 16, [0.6, 0.6, 0.6], 'filled')
daspect([1 1 1])
hold on

data = load('Ut_hospitals.txt');
scatter(data(:,3), data(:,2), 16, [1.0, 0, 0], 'filled')
daspect([1 1 1])
hold on

load('leisure');
scatter(data(:,3), data(:,2), 16, [59/255, 166/255, 26/255], 'filled')
daspect([1 1 1])
hold on

load('workplaces');
scatter(data(:,3), data(:,2), 16, [243/255, 221/255, 18/255], 'filled')
daspect([1 1 1])

data = load('Ut_retirement_homes.txt');
scatter(data(:,3), data(:,2), 16, 'm', 'filled')
daspect([1 1 1])

load('schools');
scatter(data(:,3), data(:,2), 16, [0, 0, 1], 'filled')
daspect([1 1 1])