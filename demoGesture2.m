clear; clc;

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbStates = 20;

%% Load a dataset consisting of 3 demonstrations of a 3D signal.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbUsedTraining = 6;

Data_1 = load('data/gestures/compound_1.csv');
Data_1 = Data_1';

TrainingData_1 = Data_1(:,1:nbUsedTraining*100);

Data_2 = load('data/gestures/compound_2.csv');
Data_2 = Data_2';

TrainingData_2 = Data_2(:,1:nbUsedTraining*100);

%% Training of GMM by EM algorithm, initialized by k-means clustering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global label 

[Priors_1, Mu_1, Sigma_1] = EM_init_kmeans(TrainingData_1, nbStates);
[Priors_1, Mu_1, Sigma_1] = EM(TrainingData_1, Priors_1, Mu_1, Sigma_1);

plotData(TrainingData_1,label,Mu_1,Sigma_1)

[Priors_2, Mu_2, Sigma_2] = EM_init_kmeans(TrainingData_2, nbStates);
[Priors_2, Mu_2, Sigma_2] = EM(TrainingData_2, Priors_2, Mu_2, Sigma_2);

plotData(TrainingData_2,label,Mu_2,Sigma_2)


