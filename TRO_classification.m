%% Classification

disp('---------------------------------------')
disp(' Classifying ')
disp('---------------------------------------')

tmp = load('data/TRO/compound_test.csv');
C_test{1} = tmp(1:size(tmp,1),:)';
nb_point_per_traj = 100;
nb_tests_trajs = size(tmp,1)/100;

% vector of likelihood along the trajectory
% for each test and each class
do_classification = true
if do_classification == true
    
    loglike_t = zeros( nb_point_per_traj, nb_classes, ...
    nb_tests_trajs, 1 );

    for i=1:nb_tests_trajs
        disp(['test ' num2str(i)])
        Traj = C_test{1}(:,1+(i-1)*nb_point_per_traj:i*nb_point_per_traj);

        loglike_t(:,:,i,1) = class_traj_2( ... 
            Traj, ...
            Priors_t(:,:,:,1), ...
            Mu_t(:,:,:,1), ...
            Sigma_t(:,:,:,:,1) );
    end
end

class_ground_truth = zeros(21);
class_ground_truth(1) =  2 ;
class_ground_truth(2) =  2 ;
class_ground_truth(3) =  2 ;
class_ground_truth(4) =  4 ;
class_ground_truth(5) =  2 ;
class_ground_truth(6) =  2 ;
class_ground_truth(7) =  2 ;
class_ground_truth(8) =  4 ;
class_ground_truth(9) =  4 ;
class_ground_truth(10) =  4 ;
class_ground_truth(11) =  4 ;
class_ground_truth(12) =  4 ;
class_ground_truth(13) =  3 ;
class_ground_truth(14) =  3 ;
class_ground_truth(15) =  3 ;
class_ground_truth(16) =  4 ;
class_ground_truth(17) =  4 ;
class_ground_truth(18) =  3 ;
class_ground_truth(19) =  4 ;
class_ground_truth(20) =  4 ;
class_ground_truth(21) =  4 ;

% Get all answers
nb_point_per_traj = 100;
classification = zeros( nb_tests_trajs, nb_point_per_traj );
answers = zeros( nb_tests_trajs, nb_point_per_traj );
max_likelihood = -Inf;

for i=1:nb_point_per_traj
    for k=1:nb_tests_trajs
        for j=1:nb_classes
            if loglike_t(i,j,k,1) > max_likelihood
                max_likelihood = loglike_t(i,j,k,1);
                classification(k, i) = j;
            end
        end
        max_likelihood = -Inf;
        if classification(k, i) == class_ground_truth(k)
           answers(k, i) = 1;
        end
    end
end

plot( 1:1:100, 100*mean(answers) )
axis([1 100 0 100])

csvwrite(['data/TRO/testing_classification_05.csv'], classification(:,5));
csvwrite(['data/TRO/testing_classification_10.csv'], classification(:,10));
csvwrite(['data/TRO/testing_classification_15.csv'], classification(:,15));
csvwrite(['data/TRO/testing_classification_20.csv'], classification(:,20));
csvwrite(['data/TRO/testing_classification_25.csv'], classification(:,25));
csvwrite(['data/TRO/testing_classification_30.csv'], classification(:,30));
csvwrite(['data/TRO/testing_classification_35.csv'], classification(:,35));
csvwrite(['data/TRO/testing_classification_40.csv'], classification(:,40));
csvwrite(['data/TRO/testing_classification_45.csv'], classification(:,45));
csvwrite(['data/TRO/testing_classification_50.csv'], classification(:,50));
