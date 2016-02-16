function save_gmms_to_csv(Prior,Mu,Sigma)

test_to_save = 1;

for i=1:size(Prior,3)
    csvwrite(['gmm_data/Prior_' num2str(test_to_save) ...
        '_' num2str(i) '.csv'], ...
        Prior(:,:,i,test_to_save));
end

for i=1:size(Mu,3)
    csvwrite(['gmm_data/Mu_' num2str(test_to_save) ...
        '_' num2str(i) '.csv'], ...
        Mu(:,:,i,test_to_save));
end

for i=1:size(Sigma,3)
    for j=1:size(Sigma,4)
        csvwrite(['gmm_data/Sigma_' num2str(test_to_save) ...
            '_' num2str(i) '_' num2str(j) '.csv'], ....
            Sigma(:,:,i,j,test_to_save));
    end
    
end