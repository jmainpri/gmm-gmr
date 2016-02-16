config_idx = 1;
init_config = Data(:,100*(1:25)-(100-config_idx),:);
init_config_vect = zeros(13,100);

k = 1;
for j=1:4
    for i=1:25
        init_config_vect(:,k) = init_config(:,i,j);
        k=k+1;
    end
end

dists_calsses = zeros(1,4);
k = 0

for i=1:25
    for j=i+1:25
        dists_calsses(1) = dists_calsses(1) + sum((init_config_vect(:,i)-init_config_vect(:,j)).^2).^0.5;
        k = k + 1;
    end
end

for i=26:50
    for j=i+1:50
        dists_calsses(2) = dists_calsses(2) + sum((init_config_vect(:,i)-init_config_vect(:,j)).^2).^0.5;
    end
end

for i=51:75
    for j=i+1:75
        dists_calsses(3) = dists_calsses(3) + sum((init_config_vect(:,i)-init_config_vect(:,j)).^2).^0.5;
    end
end

for i=76:100
    for j=i+1:100
    dists_calsses(4) = dists_calsses(4) + sum((init_config_vect(:,i)-init_config_vect(:,j)).^2).^0.5;
    end
end

dists_calsses = dists_calsses ./k

dists = 0;
k = 0;

for i=1:100
    for j=i+1:100
        dists = dists + sum((init_config_vect(:,i)-init_config_vect(:,j)).^2).^0.5;
        k = k + 1;
    end
end

dists = dists ./k'