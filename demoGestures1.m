clear; clc;

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbStates = 15;

%% Load a dataset consisting of 3 demonstrations of a 3D signal.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data = load('data/gestures/compound_1.csv');
Data = load('data/gestures/compound_2.csv');
Data = Data';

%load('data/data1.mat'); %load 'Data'
nbVar = size(Data,1);

%% Training of GMM by EM algorithm, initialized by k-means clustering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global label 

 [Priors, Mu, Sigma] = EM_init_kmeans(Data, nbStates);
 [Priors, Mu, Sigma] = EM(Data, Priors, Mu, Sigma);


%% Compute to which class belong the points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color = 'brgmcyk';
m = length(color);
c = max(label);

%% Plot of the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure('position',[10,10,1000,800],'name','GMM-GMR-demo1');
figure

%plot 1D
for n=1:nbVar-1
  subplot((nbVar-1),2,(n-1)*2+1); hold on;
%  plot(Data(1,:), Data(n+1,:), 'x', 'markerSize', 4, 'color', [.3 .3 .3]);
   for i = 1:c
       idc = label==i;
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

%% Use of GMR to retrieve a generalized version of the data and associated
%% constraints. A sequence of temporal values is used as input, and the 
%% expected distribution is retrieved. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% expData(1,:) = linspace(min(Data(1,:)), max(Data(1,:)), 100);
% [expData(2:nbVar,:), expSigma] = GMR(Priors, Mu, Sigma,  expData(1,:), [1], [2:nbVar]);
%  
%  %% Plot of the GMR regression results
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% %plot 1D
%  for n=1:nbVar-1
%    subplot((nbVar-1),2,(n-1)*2+1); hold on;
%    plotGMM(expData([1,n+1],:), expSigma(n,n,:), [0 0 .8], 3);
%    axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
%    xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
%  end
%  %plot 2D
% subplot((nbVar-1),2,[2:2:2*(nbVar-1)]); hold on;
% plotGMM(expData([2,3],:), expSigma([1,2],[1,2],:), [0 0 .8], 2);
% axis([min(Data(2,:))-0.01 max(Data(2,:))+0.01 min(Data(3,:))-0.01 max(Data(3,:))+0.01]);
% xlabel('x_1','fontsize',16); ylabel('x_2','fontsize',16);

% Plot 3D GMM regression results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ellip_hndls = surf(ones(2,2),ones(2,2),ones(2,2));
% [x,y,z] = ellipsoid(0,0,0,0.5,0.5,0.51,10)
% set(ellip_hndls(g),'XData',x);
% set(ellip_hndls(g),'YData',y);
% set(ellip_hndls(g),'ZData',z);
% set(ellip_hndls(g),'FaceAlpha',0.5);
% set(ellip_hndls(g),'EdgeAlpha',min(0.05,0.005,0.5));
% set(ellip_hndls(g),'FaceColor',);
% set(ellip_hndls(g),'EdgeColor',colors(g,:));

