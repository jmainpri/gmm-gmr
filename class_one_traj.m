% Returns the log-likely hood for each class
% Inputs -----------------------------------------------------------------
%   o Traj:    D x N array representing N datapoints of D dimensions.
%   o Priors : 1 x K x C array representing the initial prior probabilities 
%              of the K GMM components for each class
%   o Mu :     D x K x C array representing the initial centers of the K 
%              GMM for each class
%              components.
%   o Sigma :  D x D x K x C array representing the initial covariance 
%              matrices of the K GMM components for each class
% Outputs ----------------------------------------------------------------
%   o log_like:  1 x C array representing the prior probabilities of the K 
%               GMM average for each class components.
function result = class_one_traj( Traj, Priors, Mu, Sigma )

nb_states = size(Priors,2);
nb_classes = size(Priors,3);

Pxi = zeros( size(Traj,2), nb_states, nb_classes );
result = zeros(1, nb_classes);

% Compute probability of each class
for j=1:nb_classes
    
    for i=1:nb_states
        % Compute the new probability p(x|i)
        Pxi(:,i,j) = gaussPDF( Traj, Mu(:,i,j), Sigma(:,:,i,j) );
    end
    
    % Compute the log likelihood of the class
    F = Pxi(:,:,j)*Priors(:,:,j)';
    
    F(find(F<realmin)) = realmin;
   
    result(j) = mean(log(F));
end