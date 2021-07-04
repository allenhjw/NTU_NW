%% Main code 
clear;clc;close all;
%file_Dir="/Volumes/My Book/4_PhD Research/Experiment_Result/RAW_DATA"; %user edit the directory if needed.
file_Dir="/Users/allenhum/Documents/PhD stuffs/"; %user edit the directory if needed.
fileNameNoA="18-09-03-ALS-LOPE-ALL-DDNORM.csv"; %user input the file name to be read//
fileNameTemp="18-09-03-ALS-TEMP-ALL.csv"; %user input the file name to be read//
LayerName="ALS";
AlgoName="HiPE"; 
fopenPath=fullfile(file_Dir,fileNameNoA);
% read table from the .csv
TinputNoA=readtable(fopenPath);
fopenPath=fullfile(file_Dir,fileNameTemp);
TinputTemp=readtable(fopenPath);
allIndex_TEMP=TinputTemp.CLASS;
featNum=unique(allIndex_TEMP);
totFeat=numel(featNum);
for featCnt=1:totFeat
    % TEMP
    featIndexRng=find(TinputTemp.CLASS==featNum(featCnt));
    featIndVector=TinputTemp.TEMP(featIndexRng(1:end));
    meanTEMP(featCnt,1)=mean(featIndVector);
    STD_TEMP_GET=std(featIndVector);
    STD_TEMP(featCnt,1)=STD_TEMP_GET;
    STD_TEMP_ERRO(featCnt,1)=STD_TEMP_GET/sqrt(length(featIndVector));
    % AM
    featIndexRng=find(TinputNoA.CLASS==featNum(featCnt));
    featIndVector=TinputNoA.AM(featIndexRng(1:end));
    meanAM(featCnt,1)=mean(featIndVector);
    STD_AM_GET=std(featIndVector);
    STD_AM(featCnt,1)=STD_AM_GET;
    STD_AM_ERRO(featCnt,1)=STD_AM_GET/sqrt(length(featIndVector));
    
end
% Plotting error
% X_axis
X=[1;2;3;4;5;6;7;8;9;10];%featNum;
y_RIGHT_mean=meanTEMP;
y_LEFT_mean=meanAM;
y_err_RIGHT=STD_TEMP;
y_err_LEFT=STD_AM;

yyaxis left;
ERR_LEFT_gca=gca;
MEAN_AM_DATA=errorbar(X,y_LEFT_mean,y_err_LEFT,'--dk');
%ERR_LEFT_gca.Color='black';
ERR_LEFT_gca.XLim = [0.8 10.2];
ERR_LEFT_gca.YLim = [0 1];
ERR_LEFT_gca.YColor = 'k';
%axis(ERR_LEFT_gca,'tight')

hold on
% display the mean
%%scatgca=gca;
%%X_Var=[1;2;3;4;5;6];
%%X_Var=[{'E_0'};{'E_1'};{'E_2'};{'E_3'};{'E_4'};{'E_5'};{'E_6'};{'E_7'};{'E_8'};{'E_9'}];
%%MEAN_AM_DATA=plot(X,y_LEFT_mean, 'dk');
h_AM_MEAN=legend(MEAN_AM_DATA,'Mean $A_{m}(l,s)$','Interpreter','latex');
%hMEAN=legend(MEADATA,'meanA');
set(h_AM_MEAN,'Visible','off')

%%linkaxes([boxgca,linegca,scatgca],'xy');
%%linkaxes([ERR_LEFT_gca,scatgca],'xy');
ylabel('$\overline{A_{m}}$','Interpreter','Latex','Fontsize',20);

yyaxis right;
ERR_RIGHT_gca=gca;
MEAN_TEMP_DATA=errorbar(X,y_RIGHT_mean,y_err_RIGHT,'-sk');
%%TEMP_scatgca=gca;
ERR_RIGHT_gca.XLim=[0.8 10.2];
ERR_RIGHT_gca.YLim=[0 200];
ERR_RIGHT_gca.YColor='k';
%%MEAN_TEMP_DATA=plot(X,y_RIGHT_mean, 'sq');
h_TEMP_MEAN=legend(MEAN_TEMP_DATA,'Mean ${T_{max}}$','Interpreter','latex');
%hMEAN=legend(MEADATA,'meanA');
set(h_TEMP_MEAN,'Visible','off')
%%linkaxes([ERR_RIGHT_gca,TEMP_scatgca],'xy');
ylabel('$\overline{T_{max}}$','Interpreter','Latex','Fontsize',20);

% Title
title("Experiment set 1: LoPE alogrithm applied to ALS layers for all specimens");
xlabel('Specimens','Interpreter','Latex','Fontsize',20);



hold off
a=findall(gcf,'Type','ErrorBar');
legend([a(1,1),a(2,1)]);
p=1;

%x = 1:10:100;
%y = [20 30 45 40 60 65 80 75 95 90]; 
%err = [5 8 2 9 3 3 8 3 9 3];
%errorbar(x,y,err)
