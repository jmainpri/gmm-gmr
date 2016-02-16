clear; clc;

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nb_states = 40;
nb_traj = 25;
nb_point_per_traj = 100;
nb_left_out = 5;

%% Load a dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

Priors_t = zeros(1,nb_states,nb_classes,1);
Mu_t = zeros(nb_features,nb_states,nb_classes,1);
Sigma_t = zeros(nb_features,nb_features,nb_states,nb_classes,1);

%% Training

data_set = ((nb_left_out+1)*nb_point_per_traj:nb_traj*nb_point_per_traj)';
%     TrainingData = zeros(nb_classes,nb_features,(nb_traj-1)*nb_point_per_traj);

for k=1:nb_classes
    disp(['learn for class ' num2str(k)])
    TrainingData = Data(:,data_set,k);
    
    [Priors_t(:,:,k,1), Mu_t(:,:,k,1), Sigma_t(:,:,:,k,1)] = EM_init_kmeans( TrainingData, nb_states );
    [Priors_t(:,:,k,1), Mu_t(:,:,k,1), Sigma_t(:,:,:,k,1)] = ...
        EM( TrainingData, Priors_t(:,:,k,1), Mu_t(:,:,k,1), Sigma_t(:,:,:,k,1));
end

%% Regression 
% Regression and save the first test
disp('---------------------------------------')
disp(' Regression ')
disp('---------------------------------------')

for k=1:nb_classes
        disp(['Regrassion for class ' num2str(k)])
        expData(1,:,k) = linspace(min(Data(1,:)), max(Data(1,:)), 100);
        [expData(2:nb_features,:,k), expSigma] = GMR( ...
            Priors_t(:,:,k,1), ...
            Mu_t(:,:,k,1), ...
            Sigma_t(:,:,:,k,1), ...
            expData(1,:,k), [1], [2:nb_features]);
end


disp('---------------------------------------')
disp(' Save Regressed Motions ')
disp('---------------------------------------')
meanTraj = zeros(nb_features,100);

for k=1:nb_classes
    for n=1:nb_features
        %     figure
        %     plot(expData(n,:,k))
        meanTraj(n,:) = expData(n,:,k)';
    end
    csvwrite(['traj_class_' num2str(k) '.csv'], meanTraj');
end

disp('---------------------------------------')
disp(' Save GMMs ')
disp('---------------------------------------')
save_gmms_to_csv( Priors_t, Mu_t, Sigma_t );
