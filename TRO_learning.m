% file copied form DemoGesture5.m
clear; clc;

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nb_states = 150;
nb_tests = 1;
nb_points_per_traj = 100;
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

nb_features = size(C{1},1);
nb_classes = size(C,2);

%% Testing Phase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global label

Priors_t = zeros(1, nb_states, nb_classes, nb_tests);
Mu_t = zeros(nb_features, nb_states, nb_classes, nb_tests);
Sigma_t = zeros(nb_features, nb_features, nb_states, nb_classes, nb_tests);

%% Training 
do_training = true;
if do_training
    disp('---------------------------------------')
    disp(['Train : ' num2str(1)])
    disp('---------------------------------------')

    for k=1:nb_classes
        disp(['learn for class ' num2str(k)])
        TrainingData = C{k};

        [Priors_t(:,:,k,1), Mu_t(:,:,k,1), Sigma_t(:,:,:,k,1)] = ...
            EM_init_kmeans( TrainingData, nb_states );
        [Priors_t(:,:,k,1), Mu_t(:,:,k,1), Sigma_t(:,:,:,k,1)] = ...
            EM( TrainingData, Priors_t(:,:,k,1), Mu_t(:,:,k,1), ...
            Sigma_t(:,:,:,k,1));
    end
end

%% Regression 
% Regression and save the first test
disp('---------------------------------------')
disp(' Regression ')
disp('---------------------------------------')

for k=1:nb_classes
    disp(['Regression for class ' num2str(k)])
    expData(1,:,k) = linspace(min(C{k}(1,:)), max(C{k}(1,:)), 100);
    [expData(2:nb_features,:,k), expSigma] = GMR(... 
        Priors_t(:,:,k,1), ...
        Mu_t(:,:,k,1), ...
        Sigma_t(:,:,:,k,1), ...
        expData(1,:,k), [1], [2:nb_features]);
end

disp('---------------------------------------')
disp(' Save Regressed Motions ')
disp('---------------------------------------')
meanTraj = zeros( nb_features, nb_points_per_traj );
for k=1:nb_classes
    for n=1:nb_features
        meanTraj(n,:) = expData(n,:,k)';
    end
    csvwrite(['data/TRO/traj_class_' num2str(k) '.csv'], meanTraj');
end
