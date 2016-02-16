% Returs the 
% Inputs -----------------------------------------------------------------
%   o Data:    D x N array representing N datapoints of D dimensions.
%   o Priors0: 1 x K array representing the initial prior probabilities 
%              of the K GMM components.
%   o Mu0:     D x K array representing the initial centers of the K GMM 
%              components.
%   o Sigma0:  D x D x K array representing the initial covariance matrices 
%              of the K GMM components.
% Outputs ----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
function loglike = class_traj(Traj, ...
    Priors_1, Mu_1, Sigma_1, ...
    Priors_2, Mu_2, Sigma_2)

nbStates = size(Sigma_1,3);

loglike = zeros(100,2);

% iterate over all max length
for k=1:100
    
    max_length = k;
    
    Pxi_1 = zeros(max_length,nbStates);
    Pxi_2 = zeros(max_length,nbStates);
    
    test_data = Traj(:,1:+max_length);
    
    for i=1:nbStates
        % Compute the new probability p(x|i)
        Pxi_1(:,i) = gaussPDF(test_data, Mu_1(:,i), Sigma_1(:,:,i));
    end
    
    %Compute the log likelihood
    F = Pxi_1*Priors_1';
    F(find(F<realmin)) = realmin;
    loglike(k,1) = mean(log(F));
    
    for i=1:nbStates
        % Compute the new probability p(x|i)
        Pxi_2(:,i) = gaussPDF(test_data, Mu_2(:,i), Sigma_2(:,:,i));
    end
    
    %Compute the log likelihood
    F = Pxi_2*Priors_2';
    if
    F(find(F<realmin)) = realmin;
    loglike(k,2) = mean(log(F));
end