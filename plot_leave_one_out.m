% disp('---------------------------------------')
% disp(' Save Regressed Motions ')
% disp('---------------------------------------')
% meanTraj = zeros(nb_features,100);
% 
% for k=1:nb_classes
%     for n=1:nb_features
%         %     figure
%         %     plot(expData(n,:,k))
%         meanTraj(n,:) = expData(n,:,k)';
%     end
%     csvwrite(['traj_class_' num2str(k) '.csv'], meanTraj');
% end
% 
% disp('---------------------------------------')
% disp(' Save GMMs ')
% disp('---------------------------------------')
% save_gmms_to_csv( Priors_t, Mu_t, Sigma_t );

% 
% for k=1:nb_classes
%     figure
%     for n=1:nb_features-1
%         subplot(nb_features-1,1,n); hold on;
%         plotGMM(expData([1,n+1],:,k), expSigma(n,n,:), [0 0 .8], 3);
%         axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
%         xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
%     end
% end

log_one_point = zeros( nb_tests, nb_classes, nb_classes);
answers_one_point = zeros( 1, nb_tests*nb_classes );
point_id = 1;
test_id = 1;
for i=1:nb_tests
    disp(['test ' num2str(i)])
    
%     data_set = [1:(i-1)*nb_point_per_traj (i+1)*nb_point_per_traj:nb_traj*nb_point_per_traj]';
    data_set = 1+(i-1)*nb_point_per_traj:i*nb_point_per_traj;
    Traj = Data(:,data_set,:);
    
    for k=1:nb_classes
        log_one_point(i,:,k) = class_one_traj( ... 
            Traj(:,point_id,k), ...
            Priors_t(:,:,:,i), ...
            Mu_t(:,:,:,i), ...
            Sigma_t(:,:,:,:,i) );
%         log_first_point(i,:,k)
        [y,id] = max(log_one_point(i,:,k));
        if( id == k )
            answers_one_point(test_id) = 1;
        end
        test_id = test_id +1;
    end
end

mean(answers_one_point)

answers = zeros( nb_tests, nb_point_per_traj, nb_classes );

%Get all answers
for i=1:nb_point_per_traj
    for j=1:nb_classes
        for k=1:nb_tests
            classes = [1:(j-1) (j+1):nb_classes];
            
            likelihood_of_the_class = loglike_t(i,j,k,j);
            
            good_classification = 0;
            
            for l=1:nb_classes-1
                if(likelihood_of_the_class > loglike_t(i,classes(l),k,j))
                    good_classification = good_classification + 1;
                end
            end
           
            if good_classification == (nb_classes-1)
                answers(k,i,j) = 1;
            end
        end
    end
end

% subplot(4,1,1)
% plot(mean(answers(:,:,1)))
% ylabel('probability in class 1','fontsize',16);
% xlabel('percentage of trajectory','fontsize',16);
% axis([0 100 0 1])
% subplot(4,1,2)
% plot(mean(answers(:,:,2)))
% ylabel('probability in class 2','fontsize',16);
% xlabel('percentage of trajectory','fontsize',16);
% axis([0 100 0 1])
% subplot(4,1,3)
% plot(mean(answers(:,:,3)))
% ylabel('probability in class 3','fontsize',16);
% xlabel('percentage of trajectory','fontsize',16);
% axis([0 100 0 1])
% subplot(4,1,4)
% plot(mean(answers(:,:,4)))
% ylabel('probability in class 4','fontsize',16);
% xlabel('percentage of trajectory','fontsize',16);
% axis([0 100 0 1])

figure
plot( 0.01:0.01:1, mean(mean(answers),3) )
axis([0.01 1 0.5 1])
% xlhand = get(gca,'xlabel');
% set(xlhand,'string','X','fontsize',20)
% ylhand = get(gca,'ylabel');
% set(ylhand,'string','Y','fontsize',20)

ylabel('Recognition rate','fontsize',20);
xlabel('Executed fraction of the motion trajectory','fontsize',20);

disp('Testing')
t = cputime; 
Traj_speed_test = Data(:,1:nb_point_per_traj);
result = class_one_traj(Traj_speed_test, Priors_t(:,:,:,1), Mu_t(:,:,:,1), Sigma_t(:,:,:,:,1));
class_time = cputime-t;
disp(['classifying one traj takes : ' num2str(class_time) ' seconds'])
