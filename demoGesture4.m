clear; clc;

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbStates = 20;

%% Load a dataset consisting of 3 demonstrations of a 3D signal.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Data_1 = load('data/gestures/compound_1.csv');
Data_1 = Data_1';

Data_2 = load('data/gestures/compound_2.csv');
Data_2 = Data_2';

answers = zeros(7,100,2);

global label

%% Training of GMM by EM algorithm, initialized by k-means clustering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:7
    disp(['Train : ' num2str(i)])
    data_set = [1:(i-1)*100 (i+1)*100:7*100]';
    
    TrainingData_1 = Data_1(:,data_set);
    TrainingData_2 = Data_2(:,data_set);
    
    Traj_1 = Data_1(:,1+(i-1)*100:i*100);
    Traj_2 = Data_2(:,1+(i-1)*100:i*100);
    
    nbVar = size(Traj_1,1);
    
    [Priors_1, Mu_1, Sigma_1] = EM_init_kmeans(TrainingData_1, nbStates);
    [Priors_1, Mu_1, Sigma_1] = EM(TrainingData_1, Priors_1, Mu_1, Sigma_1);
    %plotData(TrainingData_1,label,Mu_1,Sigma_1)
    
    [Priors_2, Mu_2, Sigma_2] = EM_init_kmeans(TrainingData_2, nbStates);
    [Priors_2, Mu_2, Sigma_2] = EM(TrainingData_2, Priors_2, Mu_2, Sigma_2);
    %plotData(TrainingData_2,label,Mu_2,Sigma_2)
    
    loglike_1 = class_traj(Traj_1, Priors_1, Mu_1, Sigma_1, Priors_2, Mu_2, Sigma_2);
    loglike_2 = class_traj(Traj_2, Priors_1, Mu_1, Sigma_1, Priors_2, Mu_2, Sigma_2);
    
    for j=1:100
        if(loglike_1(j,1) > loglike_1(j,2) )
            answers(i,j,1) = 1;
        end
        if(loglike_2(j,1) < loglike_2(j,2) )
            answers(i,j,2) = 1;
        end
    end
    
%     figure
%     for n=1:nbVar-1
%         subplot((nbVar-1),2,(n-1)*2+1); hold on;
%         plot(Traj_1(1,:), Traj_1(n+1,:), 'x', 'markerSize', 4, 'color', [.3 .3 .3]);
%         axis([min(Traj_1(1,:)) max(Traj_1(1,:)) min(Traj_1(n+1,:))-0.01 max(Traj_1(n+1,:))+0.01]);
%         xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
%     end
%     for n=1:nbVar-1
%         subplot((nbVar-1),2,(n-1)*2+2); hold on;
%         plot(Traj_2(1,:), Traj_2(n+1,:), 'x', 'markerSize', 4, 'color', [.3 .3 .3]);
%         axis([min(Traj_2(1,:)) max(Traj_2(1,:)) min(Traj_2(n+1,:))-0.01 max(Traj_2(n+1,:))+0.01]);
%         xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
%     end

%     figure
%     subplot(2,1,1)
%     plot(loglike_1(:,1),'r');
%     hold on
%     subplot(2,1,1)
%     plot(loglike_1(:,2),'b');
%     ylabel('loglike','fontsize',16);
%     xlabel('percentage of trajectory','fontsize',16);
%     subplot(2,1,2)
%     plot(loglike_2(:,1),'r');
%     hold on
%     subplot(2,1,2)
%     plot(loglike_2(:,2),'b');
%     ylabel('loglike','fontsize',16);
%     xlabel('percentage of trajectory','fontsize',16);
end

figure
subplot(2,1,1)
plot(mean(answers(:,:,1)))
ylabel('probability in class 1','fontsize',16); 
xlabel('percentage of trajectory','fontsize',16);
axis([0 100 0 1])
subplot(2,1,2)
plot(mean(answers(:,:,2)))
ylabel('probability in class 2','fontsize',16); 
xlabel('percentage of trajectory','fontsize',16);
axis([0 100 0 1])