% Inputs -----------------------------------------------------------------
%   o Data:    D x N array representing N datapoints of D dimensions.
%   o Priors0: 1 x K array representing the initial prior probabilities 
%              of the K GMM components.
%   o Mu0:     D x K array representing the initial centers of the K GMM 
%              components.
%   o Sigma0:  D x D x K array representing the initial covariance matrices 
%              of the K GMM components.
% Outputs ----------------------------------------------------------------
%   o log_like of one trajectory
function loglike = class_traj_2( Traj, Priors, Mu, Sigma )

nb_partial_segments_to_try = 100;
nb_classes = size(Priors,3);
loglike = zeros(nb_partial_segments_to_try, nb_classes);

% Iterate over all max length
for k=1:nb_partial_segments_to_try
    max_length = k;
    test_data = Traj(:,1:max_length);
%     [nbVar,nbData] = size(test_data);
%     disp(nbVar)
%     disp(nbData)
    loglike(k,:) = class_one_traj( test_data, Priors, Mu, Sigma );
end


