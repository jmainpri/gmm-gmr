%% Compute log likely hood %%%%%%%%%%%%%%%%%%%%

clc

nbTraj1 = size(Data_1,2)/100;
nbTraj2 = size(Data_2,2)/100;

max_length = 100

data_full_1 = zeros(nbTraj1,size(Data_1,1),max_length);
data_full_2 = zeros(nbTraj2,size(Data_2,1),max_length);

answers_1 = zeros(7-nbUsedTraining,100);
answers_2 = zeros(7-nbUsedTraining,100);

loglike_1 = zeros(7-nbUsedTraining,100,2);
loglike_2 = zeros(7-nbUsedTraining,100,2);

for k=1:100
    
    max_length = k;
    
    Pxi_1 = zeros(max_length,nbStates);
    Pxi_2 = zeros(max_length,nbStates);
    
    for j=nbUsedTraining+1:7
        
        test_data_1 = Data_1(:,(j-1)*100+1:(j-1)*100+max_length);
%         data_full_1(j,:,:) = test_data_1;
        
        for i=1:nbStates
            % Compute the new probability p(x|i)
            Pxi_1(:,i) = gaussPDF(test_data_1, Mu_1(:,i), Sigma_1(:,:,i));
        end
        
        %Compute the log likelihood
        F = Pxi_1*Priors_1';
        F(find(F<realmin)) = realmin;
        loglik_1 = mean(log(F));
        
        for i=1:nbStates
            % Compute the new probability p(x|i)
            Pxi_2(:,i) = gaussPDF(test_data_1, Mu_2(:,i), Sigma_2(:,:,i));
        end
        
        %Compute the log likelihood
        F = Pxi_2*Priors_2';
        F(find(F<realmin)) = realmin;
        loglik_2 = mean(log(F));
        
        loglike_1(j-nbUsedTraining,k,1) = loglik_1;
        loglike_1(j-nbUsedTraining,k,2) = loglik_2;
        
        if loglik_1 > loglik_2
            answers_1(j-nbUsedTraining,k)=1;
        end
    end
    
    for j=nbUsedTraining+1:7
        
        test_data_2 = Data_2(:,(j-1)*100+1:(j-1)*100+max_length);
%         data_full_2(j,:,:) = test_data_2;
        
        for i=1:nbStates
            % Compute the new probability p(x|i)
            Pxi_1(:,i) = gaussPDF(test_data_2, Mu_1(:,i), Sigma_1(:,:,i));
        end
        %Compute the log likelihood
        F = Pxi_1*Priors_1';
        F(find(F<realmin)) = realmin;
        loglik_1 = mean(log(F));
        
        for i=1:nbStates
            % Compute the new probability p(x|i)
            Pxi_2(:,i) = gaussPDF(test_data_2, Mu_2(:,i), Sigma_2(:,:,i));
        end
        %Compute the log likelihood
        F = Pxi_2*Priors_2';
        F(find(F<realmin)) = realmin;
        loglik_2 = mean(log(F));
        
        loglike_2(j-nbUsedTraining,k,1) = loglik_1;
        loglike_2(j-nbUsedTraining,k,2) = loglik_2;
        
        if loglik_2 > loglik_1
            answers_2(j-nbUsedTraining,k)=1;
%             [num2str(k), ' is good for ', num2str(j)]
        end
    end
end

figure
subplot(2,1,1)
plot(mean(answers_1))
ylabel('probability in class 1','fontsize',16); 
xlabel('percentage of trajectory','fontsize',16);
axis([0 100 0 1])
subplot(2,1,2)
plot(mean(answers_2))
ylabel('probability in class 2','fontsize',16); 
xlabel('percentage of trajectory','fontsize',16);
axis([0 100 0 1])

for i=1:7-nbUsedTraining
    figure
    subplot(2,1,1)
    plot(loglike_1(i,:,1),'r');
    hold on
    subplot(2,1,1)
    plot(loglike_1(i,:,2),'b');
    ylabel('loglike','fontsize',16);
    xlabel('percentage of trajectory','fontsize',16);
    subplot(2,1,2)
    plot(loglike_2(i,:,1),'r');
    hold on
    subplot(2,1,2)
    plot(loglike_2(i,:,2),'b');
    ylabel('loglike','fontsize',16);
    xlabel('percentage of trajectory','fontsize',16);
end

%axis([0 100 0 1])

