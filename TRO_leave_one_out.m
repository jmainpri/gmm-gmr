% file copied form DemoGesture5.m
clear; clc;

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nb_states = 40;
nb_traj = 25;
nb_point_per_traj = 100;
nb_tests = 25;

%% Load a dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmp = load('data/TRO/compound_0.csv');
C{1} = tmp(1:size(tmp,1),:)';

tmp = load('data/TRO/compound_1.csv');
C{2} = tmp(1:size(tmp,1),:)';

tmp = load('data/TRO/compound_2.csv');
C{3} = tmp(1:size(tmp,1),:)';

tmp = load('data/TRO/compound_3.csv');
C{4} = tmp(1:size(tmp,1),:)';

nb_features = size(Data,1);
nb_classes = size(Data,3);

%% Leave one out evaluation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global label

Priors_t = zeros(1, nb_states, nb_classes, nb_tests);
Mu_t = zeros(nb_features, nb_states, nb_classes, nb_tests);
Sigma_t = zeros(nb_features, nb_features, nb_states, nb_classes, nb_tests);

%% Training 

for i=1:nb_tests
    disp('---------------------------------------')
    disp(['Train : ' num2str(i)])
    disp('---------------------------------------')
    % Leave one out
    data_set = [1:(i-1)*nb_point_per_traj ...
        (i+1)*nb_point_per_traj:nb_traj*nb_point_per_traj]';
%     TrainingData = zeros(nb_classes,nb_features,...
% (nb_traj-1)*nb_point_per_traj);
    
    for k=1:nb_classes
        disp(['learn for class ' num2str(k)])
        TrainingData = Data(:,data_set,k);
        
        [Priors_t(:,:,k,i), Mu_t(:,:,k,i), Sigma_t(:,:,:,k,i)] = ...
            EM_init_kmeans( TrainingData, nb_states );
        [Priors_t(:,:,k,i), Mu_t(:,:,k,i), Sigma_t(:,:,:,k,i)] = ...
            EM( TrainingData, Priors_t(:,:,k,i), Mu_t(:,:,k,i), ...
            Sigma_t(:,:,:,k,i));
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
