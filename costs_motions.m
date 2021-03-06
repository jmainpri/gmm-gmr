clc;

% -------------------
%  Human motion 0
% -------------------
costs_1(1) = 0.0641594;
costs_1(2) = 0.307911;
costs_1(3) = 0.0766864;
costs_1(4) = 0.603591;
costs_1(5) = 0.456271;
costs_1(6) = 0.421783;
costs_1(7) = 0.758098;
costs_1(8) = 0.389314;
costs_1(9) = 0.683081;
costs_1(10) = 0.414202;
% -------------------
%  Human motion 1
% -------------------
costs_2(1) = 0.500062;
costs_2(2) = 0.588208;
costs_2(3) = 0.40351;
costs_2(4) = 0.444505;
costs_2(5) = 0.382382;
costs_2(6) = 0.396125;
costs_2(7) = 0.336525;
costs_2(8) = 0.887423;
costs_2(9) = 0.550336;
costs_2(10) = 0.436341;
% -------------------
%  Human motion 2
% -------------------
costs_3(1) = 0.628969;
costs_3(2) = 0.670597;
costs_3(3) = 0.425077;
costs_3(4) = 0.456164;
costs_3(5) = 0.390523;
costs_3(6) = 0.60041;
costs_3(7) = 0.911988;
costs_3(8) = 0.587371;
costs_3(9) = 0.935298;
costs_3(10) = 0.492131;
% -------------------
%  Human motion 3
% -------------------
costs_4(1) = 0.841897;
costs_4(2) = 0.426642;
costs_4(3) = 0.144206;
costs_4(4) = 0.668246;
costs_4(5) = 0.498696;
costs_4(6) = 0.274545;
costs_4(7) = 0.0836824;
costs_4(8) = 0.398978;
costs_4(9) = 0.377196;
costs_4(10) = 0.442855;
% -------------------
%  Human motion 4
% -------------------
costs_5(1) = 0.550884;
costs_5(2) = 0.562812;
costs_5(3) = 0.397562;
costs_5(4) = 1.09953;
costs_5(5) = 0.707019;
costs_5(6) = 0.420199;
costs_5(7) = 1.09213;
costs_5(8) = 0.409105;
costs_5(9) = 1.3235;
costs_5(10) = 0.869708;

mean(costs_1)
mean(costs_2)
mean(costs_3)
mean(costs_4)
mean(costs_5)

% -------------------
%  Human motion 0
% -------------------
costs_0(1) = 27.4122;
costs_0(2) = 17.8438;
costs_0(3) = 22.2124;
costs_0(4) = 29.1403;
costs_0(5) = 12.1878;
costs_0(6) = 16.7551;
costs_0(7) = 24.8013;
costs_0(8) = 30.564;
costs_0(9) = 38.2152;
costs_0(10) = 25.0156;
% -------------------
%  Human motion 1
% -------------------
costs_1(1) = 20.6704;
costs_1(2) = 24.3381;
costs_1(3) = 16.3452;
costs_1(4) = 22.376;
costs_1(5) = 31.1526;
costs_1(6) = 22.3008;
costs_1(7) = 16.9285;
costs_1(8) = 22.7474;
costs_1(9) = 12.172;
costs_1(10) = 25.731;
% -------------------
%  Human motion 2
% -------------------
costs_2(1) = 37.4473;
costs_2(2) = 34.5703;
costs_2(3) = 17.4371;
costs_2(4) = 25.6087;
costs_2(5) = 33.249;
costs_2(6) = 41.3752;
costs_2(7) = 26.1086;
costs_2(8) = 17.1195;
costs_2(9) = 25.3037;
costs_2(10) = 17.0483;
% -------------------
%  Human motion 3
% -------------------
costs_3(1) = 26.7581;
costs_3(2) = 21.2532;
costs_3(3) = 31.5389;
costs_3(4) = 33.5341;
costs_3(5) = 18.2525;
costs_3(6) = 25.1194;
costs_3(7) = 16.7143;
costs_3(8) = 24.468;
costs_3(9) = 21.8142;
costs_3(10) = 25.0466;
% -------------------
%  Human motion 4
% -------------------
costs_4(1) = 27.9254;
costs_4(2) = 35.1505;
costs_4(3) = 17.2433;
costs_4(4) = 24.4166;
costs_4(5) = 16.3133;
costs_4(6) = 24.3107;
costs_4(7) = 33.7672;
costs_4(8) = 24.4166;
costs_4(9) = 24.5879;
costs_4(10) = 23.2091;

disp('---------------------')
mean(costs_0)
mean(costs_1)
mean(costs_2)
mean(costs_3)
mean(costs_4)

% -------------------
%  Two Cup
% -------------------
cost_0_(0+1) = 0.00182665;
cost_0_(1+1) = 0.00175721;
cost_0_(2+1) = 0.0222343;
cost_0_(3+1) = 0.411926;
cost_0_(4+1) = 0.4111;
cost_0_(5+1) = 0.38782;
cost_0_(6+1) = 0.35636;
cost_0_(7+1) = 0.325554;
cost_0_(8+1) = 0.255406;
cost_0_(9+1) = 0.198753;
cost_0_(10+1) = 0.228089;
cost_0_(11+1) = 0.182511;
cost_0_(12+1) = 0.180242;
cost_0_(13+1) = 0.178968;
cost_0_(14+1) = 0.161251;
cost_0_(15+1) = 0.156812;
cost_0_(16+1) = 0.147071;
cost_0_(17+1) = 0.157525;
cost_0_(18+1) = 0.139154;
cost_0_(19+1) = 0.116526;

cost_1_(0+1) = 1.57136;
cost_1_(1+1) = 0.956891;
cost_1_(2+1) = 0.614697;
cost_1_(3+1) = 0.0563688;
cost_1_(4+1) = 0.0191413;
cost_1_(5+1) = 0.00279078;
cost_1_(6+1) = 0.00258962;
cost_1_(7+1) = 0.00446684;
cost_1_(8+1) = 0.0759726;
cost_1_(9+1) = 0.0784057;
cost_1_(10+1) = 0.00321776;
cost_1_(11+1) = 0.00211186;
cost_1_(12+1) = 0.00201141;
cost_1_(13+1) = 0.00193123;
cost_1_(14+1) = 0.00189807;
cost_1_(15+1) = 0.00177249;
cost_1_(16+1) = 0.00168268;
cost_1_(17+1) = 0.0015896;
cost_1_(18+1) = 0.00155921;
cost_1_(19+1) = 0.0014473;


% plot(cost_0_)
% hold on
% plot(cost_1_)

%%---------------------------------------------
%% New 19 march tuesday

% cost_0_(0+1) = 0.00183323;
% cost_0_(1+1) = 0.00172152;
% cost_0_(2+1) = 0.00156691;
% cost_0_(3+1) = 0.00139202;
% cost_0_(4+1) = 0.00122087;
% cost_0_(5+1) = 0.00110959;
% cost_0_(6+1) = 0.000954024;
% cost_0_(7+1) = 0.000857501;
% cost_0_(8+1) = 0.000716679;
% cost_0_(9+1) = 0.00065852;
% cost_0_(10+1) = 0.000795936;
% cost_0_(11+1) = 0.000679665;
% cost_0_(12+1) = 0.000532121;
% cost_0_(13+1) = 0.029694;
% cost_0_(14+1) = 0.116012;
% cost_0_(15+1) = 0.391819;
% cost_0_(16+1) = 1.10426;
% cost_0_(17+1) = 0.913198;
% cost_0_(18+1) = 0.921623;
% cost_0_(19+1) = 0.941458;
% cost_1_(0+1) = 0.00307302;
% cost_1_(1+1) = 0.00295016;
% cost_1_(2+1) = 0.00279938;
% cost_1_(3+1) = 0.00270633;
% cost_1_(4+1) = 0.00255907;
% cost_1_(5+1) = 0.0025216;
% cost_1_(6+1) = 0.00230585;
% cost_1_(7+1) = 0.00221144;
% cost_1_(8+1) = 0.00207903;
% cost_1_(9+1) = 0.00199223;
% cost_1_(10+1) = 0.00192951;
% cost_1_(11+1) = 0.00208686;
% cost_1_(12+1) = 0.00210621;
% cost_1_(13+1) = 0.00206682;
% cost_1_(14+1) = 0.00188081;
% cost_1_(15+1) = 0.00170653;
% cost_1_(16+1) = 0.00153034;
% cost_1_(17+1) = 0.00134623;
% cost_1_(18+1) = 0.00122581;
% cost_1_(19+1) = 0.00104556;
% 
% plot(cost_0_)
% axis([1 20 0 0.02])
% hold on
% plot(cost_1_)

cost_0_(1) = 0.00181813;
cost_0_(2) = 0.00167872;
cost_0_(3) = 0.0265973;
cost_0_(4) = 0.448542;
cost_0_(5) = 0.383505;
cost_0_(6) = 0.339955;
cost_0_(7) = 0.321021;
cost_0_(8) = 0.304216;
cost_0_(9) = 0.223452;
cost_0_(10) = 0.215249;
cost_0_(11) = 0.237955;
cost_0_(12) = 0.229748;
cost_0_(13) = 0.200707;
cost_0_(14) = 0.211694;
cost_0_(15) = 0.204162;
cost_0_(16) = 0.206481;
cost_0_(17) = 0.209649;
cost_0_(18) = 0.149836;
cost_0_(19) = 0.150318;
cost_0_(20) = 0.146941;
cost_1_(1) = 1.55956;
cost_1_(2) = 0.973761;
cost_1_(3) = 0.536696;
cost_1_(4) = 0.0483653;
cost_1_(5) = 0.0158306;
cost_1_(6) = 0.00246456;
cost_1_(7) = 0.00227421;
cost_1_(8) = 0.00326298;
cost_1_(9) = 0.0511887;
cost_1_(10) = 0.0451407;
cost_1_(11) = 0.0022935;
cost_1_(12) = 0.00148322;
cost_1_(13) = 0.00132019;
cost_1_(14) = 0.00119332;
cost_1_(15) = 0.00110118;
cost_1_(16) = 0.000888907;
cost_1_(17) = 0.000724066;
cost_1_(18) = 0.000567379;
cost_1_(19) = 0.000493693;
cost_1_(20) = 0.000527242;

figure
plot(cost_0_)
axis([1 20 0 02])
hold on
plot(cost_1_)


cost_0_(1) = 0.00184612;
cost_0_(2) = 0.0017111;
cost_0_(3) = 0.00153854;
cost_0_(4) = 0.00138368;
cost_0_(5) = 0.0012314;
cost_0_(6) = 0.00106551;
cost_0_(7) = 0.000977689;
cost_0_(8) = 0.000797317;
cost_0_(9) = 0.00065787;
cost_0_(10) = 0.00049616;
cost_0_(11) = 0.000659307;
cost_0_(12) = 0.000588842;
cost_0_(13) = 0.000485476;
cost_0_(14) = 0.0129632;
cost_0_(15) = 0.160168;
cost_0_(16) = 0.473044;
cost_0_(17) = 1.15726;
cost_0_(18) = 0.934127;
cost_0_(19) = 0.851457;
cost_0_(20) = 0.851101;
cost_1_(1) = 0.00308516;
cost_1_(2) = 0.00294186;
cost_1_(3) = 0.00281392;
cost_1_(4) = 0.00267276;
cost_1_(5) = 0.00255338;
cost_1_(6) = 0.00241864;
cost_1_(7) = 0.00230245;
cost_1_(8) = 0.00221372;
cost_1_(9) = 0.00216266;
cost_1_(10) = 0.0020548;
cost_1_(11) = 0.0020258;
cost_1_(12) = 0.00205097;
cost_1_(13) = 0.00218548;
cost_1_(14) = 0.00209348;
cost_1_(15) = 0.00189902;
cost_1_(16) = 0.00176737;
cost_1_(17) = 0.00158443;
cost_1_(18) = 0.00144275;
cost_1_(19) = 0.00128897;
cost_1_(20) = 0.00110487;

figure
plot(cost_0_)
axis([1 20 0 .02])
hold on
plot(cost_1_)


