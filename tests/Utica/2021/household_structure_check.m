%% Checking the household structure

clear;

%% ------------------- PART 1
load('hs_and_age')
% Total number of households without RH and hospitals
% ****** Change this according to your data
ntot = 22920;

% ------ Comment out from here when running other parts 
% Accidental in the retirement homes
% ****** Each row corresponds to one retirement home, update given the
% number of retirement homes that are in your dataset; in both yours and
% this code the retirement homes appear first, this is taking advantage of
% it - first 5 rows are the retirement homes
% This test should end with an empty array for each home, it checks if
% there are (accidentally) any residents that are younger than 60 y.o.
ind=find(data(1,2:end)<60)
ind=find(data(2,2:end)<60)
ind=find(data(3,2:end)<60)
ind=find(data(4,2:end)<60)
ind=find(data(5,2:end)<60)
ind=find(data(6,2:end)<60)
ind=find(data(7,2:end)<60)
ind=find(data(8,2:end)<60)
ind=find(data(9,2:end)<60)
ind=find(data(10,2:end)<60)
ind=find(data(11,2:end)<60)
ind=find(data(12,2:end)<60)

% + 4 hospitals

% At least one adult in each household
% ****** Here 17 means 12 retirement homes + 4 hospital, starting with index
% 7 (counting from 1) the locations are actual households - adjust
% accordingly to your town - none of this should print empty
disp('Checking for presence of adults in households')
for i=17:size(data,1)
    temp = data(i,~isnan(data(i,:)));
    ind = find(temp(2:end)>=18);
    if (isempty(ind))
        disp(ind)
        disp(i)
    end
end

% Number of families
% Compare against (1-fr.couples no children)
% ****** You need to use your Census data to change
% fr_cno_ch (fraction couples no childer) and fr_f (fraction families)
% as well as the index (best make that index a
% variable, this was all really rushed)
num_fam = 0;
fr_cno_ch = 0.52;
fr_f = 0.57;
for i=17:size(data,1)
    temp = data(i,~isnan(data(i,:)));
    ind = find(temp(2:end)<18);
    if (~isempty(ind))
        num_fam = num_fam + 1;
    end
end
disp('Expected families with children')
disp((1-fr_cno_ch))
disp('Actual')
disp(num_fam/(fr_f*ntot))

% Fraction of single parent families
% ****** Same - index again, but also single parent household fraction
% (ac_sp) 
num_sp = 0;
ac_sp = 0.25;
for i=17:size(data,1)
    temp = data(i,~isnan(data(i,:)));
    ind = find(temp(2:end)<18);
    indp = find(temp(2:end)>=18 & temp(2:end)<=60);
    if (~isempty(ind) & size(indp,2) == 1)
        num_sp = num_sp + 1;
    end
end
disp('Expected single parent families')
disp(ac_sp)
disp('Actual')
disp(num_sp/(fr_f*ntot))

% Households with a person 60+
% ****** Change this according to your data on fraction of households with
% a 60+ person (ac_60hs) + update the index
num_hs60 = 0;
ac_60hs = 0.378;
for i=17:size(data,1)
    temp = data(i,~isnan(data(i,:)));
    indp = find(temp(2:end)>=60);
    if (~isempty(indp))
        num_hs60 = num_hs60 + 1;
    end
end
disp('Expected % households with a person 60+')
disp(ac_60hs)
disp('Actual')
disp(num_hs60/ntot)

% Plot household age distribution
% ****** This is just visual, it shows ages in select households, check it
% out for anything weird (adjust the index)
clrB = [23/255, 119/255, 215/255];
for i=17:500:size(data,1)
    temp = data(i,~isnan(data(i,:)));
    scatter(temp(1)*ones(size(temp,2)-1,1),temp(2:end), 46, clrB, 'filled')
    hold on
    clrB = [rand(1), rand(1), 215/255];
end

%% ------------------- PART 2
% %% Work statistics
% 
% load('hs_and_work')
% 
% % Check if no agent in the retirement home or hospital patient works
% % ****** Change the limits of this loop - this needs to be the number of
% % retirement homes + number of hospitals; none of the residents/patients 
% % should be employed 
% for i=1:16
%     for j=2:length(data_work(i,:))
%         if strcmp(data_work(i,j), 'True')
%             disp('Agent in an RH or hospital patient is employed')
%             disp(i)
%             disp(j)
%         end
%     end
% end
% 
% % Compute fraction of households with at least one working agent
% % ****** Adjust index like before
% n_working_hs = 0;
% for i=17:size(data_work,1)
%     wflag = 0;
%     for j=2:length(data_work(i,:))
%         if strcmp(data_work(i,j), 'True')
%             wflag = 1;
%         end
%     end
%     if wflag
%        n_working_hs = n_working_hs + 1;
%        wflag = 0;
%     end
% end
% disp('Households with at least one working agent')
% n_working_hs/ntot
% 
% % Collect number of agents working in each household
% % ****** Adjust index like before
% for i=17:size(data_work,1)
%     n_work_hs(i-16) = 0;
%     for j=2:length(data_work(i,:))
%         if strcmp(data_work(i,j), 'True')
%             n_work_hs(i-16) = n_work_hs(i-16) + 1; 
%         end
%     end
% end
% 
% % Then find and plot occurences of each number
% n_uq = unique(n_work_hs);
% prct_uq = zeros(size(n_uq));
% for i=1:length(n_uq)
%     ind = find(n_work_hs == n_uq(i));
%     prct_uq(i) = length(ind)/length(n_work_hs)*100;
% end
% pie(prct_uq)
% 
% % Collect number of agents working in each family
% n_work_hs = zeros(size(data_work_fam,1),1);
% for i=1:size(data_work_fam,1)
%     n_work_hs(i) = 0;
%     for j=2:length(data_work_fam(i,:))
%         if strcmp(data_work_fam(i,j), 'True')
%             n_work_hs(i) = n_work_hs(i) + 1; 
%         end
%     end
% end
% 
% % Then find and plot occurences of each number
% n_uq = unique(n_work_hs);
% prct_uq = zeros(size(n_uq));
% for i=1:length(n_uq)
%     ind = find(n_work_hs == n_uq(i));
%     prct_uq(i) = length(ind)/length(n_work_hs)*100;
% end
% prct_adjusted = [prct_uq(1), prct_uq(2), sum(prct_uq(3:end))]
% pie(prct_adjusted)

%% ------------------- PART 3

%% Workplace IDs
% load('house_work_IDs')
% % Number of households where all members work at the same place
% % -1 is hospital, 0 is no workID
% n_same_work = 0;
% for i=1:size(hswIDs,1)
%     temp = hswIDs(i,~isnan(hswIDs(i,:)));
%     non_zero = size(find(temp(2:end)>0 | temp(2:end)==-1),1);
%     n_uq = unique(temp(2:end));
%     if non_zero == (n_uq - 1)
%         n_same_work = n_same_work + 1;
%     end
% end
% disp('Fraction working at the same workplace')
% n_same_work/size(hswIDs,1)

%% ------------------- PART 4

%% School attendance 
% load('hs_school')

% % Check if no retirement home or hospital patients are attending
% % % ****** Adjust max index to RH + hospitals
% for i=1:6
%     for j=2:length(schools(i,:))
%         if strcmp(schools(i,j), 'True')
%             disp('Agent in an RH or hospital patient attends school')
%             disp(i)
%             disp(j)
%         end
%     end
% end
% 






