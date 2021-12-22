edges = 1:5;

% Colonie
data1 = [47.75, 16.15, 23.67, 5.37, 7.07];
% NR
data2 = [47.84, 16.59, 19.31, 6.19, 10.05];
% Utica
data3 = [28.35, 28.5, 21.98, 6.63, 14.55];

figure
bar(edges,[data1; data2; data3]')