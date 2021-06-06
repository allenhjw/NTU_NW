%% main function to plot the box plot with the given vector load from csv file.
% 
% % Description: Load the .csv from the user specific directory and plot
% the box plot.

%% Authorship and revision 
% %Author: Allen Hum J.W
% % input:
% % output:
% %Revision: 0
% %Data: 8 May 2020
% %Purpose: Created newly
%% Main code 
clear;clc;close all;
file_Dir="/Volumes/My Book/4_PhD Research/Experiment_Result/RAW_DATA"; %user edit the directory if needed.
%file_Dir="/Users/allenhum/Documents/MATLAB/Experiment/R Prog/"; %user edit the directory if needed.
fileNameNoA="ALL_NORM_S1-3-6-8_NOA.csv"; %user input the file name to be read//
fileNameTemp="EXP 18-09-03-Mean-TEMP-ALS-S1-3-6-8_VER2.csv"; %user input the file name to be read//
LayerName="ALS";
AlgoName="HiPE"; 
fopenPath=fullfile(file_Dir,fileNameNoA);
% read table from the .csv
TinputNoA=readtable(fopenPath);
fopenPath=fullfile(file_Dir,fileNameTemp);
TinputTemp=readtable(fopenPath);
allIndex=TinputNoA.Var1;
featNum=unique(allIndex);
totFeat=numel(featNum);
for featCnt=1:totFeat
    featIndexRng=find(TinputNoA.Var1==featNum(featCnt));
    featIndVector=TinputNoA.Var2(featIndexRng(1:end));
    meanfeatIndVector(featCnt,1)=mean(featIndVector);
end

% Plot the boxplot
xVector=TinputNoA.Var2;
group=TinputNoA.Var1;

yyaxis left;
boxgca=gca;
bp=boxplot(xVector,group); set(bp(7,:),'Visible','off');
%%ylim([0 0.8]); % only 
boxgca.FontSize=20;boxgca.FontWeight='bold';
boxgca.YColor=[0 0 0];
boxgca.XGrid=1;boxgca.YGrid=1;
Title="Experiment No.1 AFR with HiPE applied to all specimens";
YLabel="Normalize area of active pixel, N[A_s_o_b (l,F)]";
ylabel(YLabel);
XLabel='Laser power (P)';
xlabel(XLabel);
hBOX=legend(findall(gca,'Tag','Median'), {'Median $A_{m}(l,s)$','Interpreter','latex'});
set(hBOX,'Visible','off')
hold on;
yyaxis right;
linegca=gca;
X_Var=[1;2;3;4]; %5;6;7;8;9;10
DATA_TEMP=plot(X_Var,TinputTemp.Var2,'k-o');
%hTEMP1=legend(findall(gca,'Tag','data1'), {'Mean Temp'});
hTEMP=legend(DATA_TEMP,'$\overline{T_{max}}$','Interpreter','Latex');
%hTEMP=legend(DATA_TEMP,'meanT');
set(hTEMP,'Visible','off')
%hold on
linegca.YColor=[0 0 0];
%YLabel="Temperature";
ylabel('$\overline{T_{max}}$','Interpreter','Latex','Fontsize',20);
hold on
yyaxis left;
scatgca=gca;
X_Var=[1;2;3;4];
%X_Var=[{'E_0'};{'E_1'};{'E_2'};{'E_3'};{'E_4'};{'E_5'};{'E_6'};{'E_7'};{'E_8'};{'E_9'}];
MEADATA=plot(X_Var,meanfeatIndVector, 'dk');
hMEAN=legend('Mean $A_{m}(l,s)$','Interpreter','latex');
%hMEAN=legend(MEADATA,'meanA');
set(hMEAN,'Visible','off')
hold on
%%linkaxes([boxgca,linegca,scatgca],'xy');
linkaxes([boxgca,scatgca],'xy');
ylabel('$A_{m}(l,s)$','Interpreter','Latex','Fontsize',20);
hold off
title("Experiment No.1 HiPE algorithm applied to ALS layers for specimens 1, 3, 6 and 8. v= 550 mm/s");
%YLabel="Normalize area of active pixel, N[A_s_o_b (l,F)]";
%YLabel="Hardness, HV";
%XLabel="Specimens";
a=findall(gcf,'Type','line');
%hBOX=legend(findall(gca,'Tag','Median'), {'Median'});
%hMEAN=legend('mean $A_{m}(l,s)$','Interpreter','latex');
%hTEMP=legend('$\overline{T_{max}}$','Interpreter','Latex');
%showLeg=legend(findall(gca,'Tag',{'Median','meanT'}),'Median','meanT');
legend([a(1,1),a(2,1),a(7,1)])
p=1;



