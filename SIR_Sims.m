%SIR_sims

DArray = [];
propWithoutCovidArray = [];

%% Initial infections
%for i=1:500
%    [~, D, propWithoutCovid]=SIR_Model(2000-i,i,0,0.02,30, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Initially Vaccinated
%for i=1:200
%    [~, D, propWithoutCovid]=SIR_Model(1800-(i*9),200,i*9,0.02,30, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Masking policies
%for i=1:200
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02-(i*0.00025),30, 0, 7, false, 0, 0, false, true, 365 , .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Distancing Policies
%for i=1:200
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 50-i/4, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Test Everyone
%for i=1:200
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 30, 0, i-1, true, 0, 0, false, true, 365, .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Vaccine mandate + Testing
%for i=1:200
%    [~, D, propWithoutCovid]=SIR_Model(100,200,1700,0.02, 30, 0, i-1, true, 0, 0, true, true, 365, .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Vaccine mandate + Testing
%for i=1:200
%    [~, D, propWithoutCovid]=SIR_Model(100,200,1700,0.02, 30, 0, i-1, true, 0, 0, true, true, 365, .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Recovery rate
%for i=0:200
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .06+i*0.0001, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end

%% Immunity loss
for i=0:200
    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .07, i*0.0001, 0.00115);
    DArray=[DArray, D];
    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
end

%% Death rate
%for i=1:200
%    [~, D, propWithoutCovid]=SIR_Model(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .07, .01, 0.00115);
%    DArray=[DArray, D];
%    propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%end


%% Outputs
    Deaths=DArray';
    Covid_Free=propWithoutCovidArray';

    plot(Deaths)
