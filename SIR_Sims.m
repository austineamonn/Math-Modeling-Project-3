%SIR_sims



loopnum=200;
DArray = zeros(1,loopnum);
propWithoutCovidArray = zeros(1,loopnum);

%% Initial infections
%for i=1:loopnum
%    [~, D, propWithoutCovid]=SIR_Model(2000-i,i,0,0.02,30, 0, 7, false, 0, 0, false, true);
%    DArray(1,i)=D;
%    propWithoutCovidArray(1,i)=propWithoutCovid;
%end

%% Initially Vaccinated
%for i=1:loopnum
%    [~, D, propWithoutCovid]=SIR_Model(1800-(i*9),200,i*9,0.02,30, 0, 7, false, 0, 0, false, true);
%    DArray(1,i)=D;
%    propWithoutCovidArray(1,i)=propWithoutCovid;
%end

%% Masking policies
%for i=1:loopnum
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02-(i*0.00025),30, 0, 7, false, 0, 0, false, true);
%    DArray(1,i)=D;
%    propWithoutCovidArray(1,i)=propWithoutCovid;
%end

%% Distancing Policies
%for i=1:loopnum
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 50-i/4, 0, 7, false, 0, 0, false, true);
%    DArray(1,i)=D;
%    propWithoutCovidArray(1,i)=propWithoutCovid;
%end

%% Test Everyone
%for i=1:loopnum
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 30, 0, i-1, true, 0, 0, false, true);
%    DArray(1,i)=D;
%    propWithoutCovidArray(1,i)=propWithoutCovid;
%end

%% Vaccines + Testing
for i=1:loopnum
    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 30, 0, i-1, true, 0, 0, true, true);
    DArray(1,i)=D;
    propWithoutCovidArray(1,i)=propWithoutCovid;
end

%%


%% Outputs
    Deaths=DArray
    Covid_Free=propWithoutCovidArray
