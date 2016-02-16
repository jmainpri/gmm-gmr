function plotData(Data,label_color,Mu, Sigma)
%% Compute to which class belong the points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbVar = size(Data,1);

color = 'brgmcyk';
m = length(color);
c = max(label_color);

figure

%plot 1D
for n=1:nbVar-1
    subplot((nbVar-1),2,(n-1)*2+1); hold on;
    %  plot(Data(1,:), Data(n+1,:), 'x', 'markerSize', 4, 'color', [.3 .3 .3]);
    for i = 1:c
        idc = label_color==i;
        scatter(Data(1,idc),Data(n+1,idc),7,color(mod(i-1,m)+1),'o');
    end
    axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
    xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
end
%plot 2D
subplot((nbVar-1),2,[2:2:2*(nbVar-1)]); hold on;
plot(Data(2,:), Data(3,:), 'x', 'markerSize', 4, 'color', [.3 .3 .3]);
axis([min(Data(2,:))-0.01 max(Data(2,:))+0.01 min(Data(3,:))-0.01 max(Data(3,:))+0.01]);
xlabel('x_1','fontsize',16); ylabel('x_2','fontsize',16);

%% Plot of the GMM encoding results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
%plot 1D
for n=1:nbVar-1
    subplot((nbVar-1),2,(n-1)*2+1); hold on;
    plotGMM(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [0 .8 0], 1);
    axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
    xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
end
%plot 2D
subplot((nbVar-1),2,[2:2:2*(nbVar-1)]); hold on;
plotGMM(Mu([2,3],:), Sigma([2,3],[2,3],:), [0 .8 0], 1);
axis([min(Data(2,:))-0.01 max(Data(2,:))+0.01 min(Data(3,:))-0.01 max(Data(3,:))+0.01]);
xlabel('x_1','fontsize',16); ylabel('x_2','fontsize',16);