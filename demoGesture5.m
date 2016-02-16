clear; clc;

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nb_states = 40;
nb_traj = 25;
nb_point_per_traj = 100;
nb_tests = 25;

%% Load a dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Data = zeros(nb_features,nb_point_per_traj*nb_traj,nb_classes);

% tmp = load('data/gestures/4classes/joints/compound_0.csv');
% Data(:,:,1) = tmp(1:(nb_traj*nb_point_per_traj),:)';
% tmp = load('data/gestures/4classes/joints/compound_1.csv');
% Data(:,:,2) = tmp(1:(nb_traj*nb_point_per_traj),:)';
% tmp = load('data/gestures/4classes/joints/compound_2.csv');
% Data(:,:,3) = tmp(1:(nb_traj*nb_point_per_traj),:)';
% tmp = load('data/gestures/4classes/joints/compound_3.csv');
% Data(:,:,4) = tmp(1:(nb_traj*nb_point_per_traj),:)';

tmp = load('data/gestures/8classes/compound_0.csv');
Data(:,:,1) = tmp(1:(nb_traj*nb_point_per_traj),:)';
tmp = load('data/gestures/8classes/compound_1.csv');
Data(:,:,2) = tmp(1:(nb_traj*nb_point_per_traj),:)';
tmp = load('data/gestures/8classes/compound_2.csv');
Data(:,:,3) = tmp(1:(nb_traj*nb_point_per_traj),:)';
tmp = load('data/gestures/8classes/compound_3.csv');
Data(:,:,4) = tmp(1:(nb_traj*nb_point_per_traj),:)';
tmp = load('data/gestures/8classes/compound_4.csv');
Data(:,:,5) = tmp(1:(nb_traj*nb_point_per_traj),:)';
tmp = load('data/gestures/8classes/compound_5.csv');
Data(:,:,6) = tmp(1:(nb_traj*nb_point_per_traj),:)';
tmp = load('data/gestures/8classes/compound_6.csv');
Data(:,:,7) = tmp(1:(nb_traj*nb_point_per_traj),:)';
tmp = load('data/gestures/8classes/compound_7.csv');
Data(:,:,8) = tmp(1:(nb_traj*nb_point_per_traj),:)';

nb_features = size(Data,1);
nb_classes = size(Data,3);

%% Leave one out evaluation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global label

Priors_t = zeros(1,nb_states,nb_classes,nb_tests);
Mu_t = zeros(nb_features,nb_states,nb_classes,nb_tests);
Sigma_t = zeros(nb_features,nb_features,nb_states,nb_classes,nb_tests);

%% Training 

for i=1:nb_tests
    disp('---------------------------------------')
    disp(['Train : ' num2str(i)])
    disp('---------------------------------------')
    % Leave one out
    data_set = [1:(i-1)*nb_point_per_traj (i+1)*nb_point_per_traj:nb_traj*nb_point_per_traj]';
%     TrainingData = zeros(nb_classes,nb_features,(nb_traj-1)*nb_point_per_traj);
    
    for k=1:nb_classes
        disp(['learn for class ' num2str(k)])
        TrainingData = Data(:,data_set,k);
        
        [Priors_t(:,:,k,i), Mu_t(:,:,k,i), Sigma_t(:,:,:,k,i)] = EM_init_kmeans( TrainingData, nb_states );
        [Priors_t(:,:,k,i), Mu_t(:,:,k,i), Sigma_t(:,:,:,k,i)] = ...
            EM( TrainingData, Priors_t(:,:,k,i), Mu_t(:,:,k,i), Sigma_t(:,:,:,k,i));
    end
end

%% Classification 

disp('---------------------------------------')
disp(' Classifying ')
disp('---------------------------------------')

% vector of likelihood along the trajectory
% for each test and each class
loglike_t = zeros( nb_point_per_traj, nb_classes, nb_tests, nb_classes );

for i=1:nb_tests
    disp(['test ' num2str(i)])
    Traj = Data(:,1+(i-1)*nb_point_per_traj:i*nb_point_per_traj,:);
%     size(Traj)
    for k=1:nb_classes
        loglike_t(:,:,i,k) = class_traj_2( ... 
            Traj(:,:,k), ...
            Priors_t(:,:,:,i), ...
            Mu_t(:,:,:,i), ...
            Sigma_t(:,:,:,:,i) );
    end
end

%% Regression 
% Regression and save the first test
disp('---------------------------------------')
disp(' Regression ')
disp('---------------------------------------')

test_to_save = 1;

for k=1:nb_classes
        disp(['Regrassion for class ' num2str(k)])
        expData(1,:,k) = linspace(min(Data(1,:)), max(Data(1,:)), 100);
        [expData(2:nb_features,:,k), expSigma] = GMR(... 
            Priors_t(:,:,k,test_to_save), ...
            Mu_t(:,:,k,test_to_save), ...
            Sigma_t(:,:,:,k,test_to_save), ...
            expData(1,:,k), [1], [2:nb_features]);
end
