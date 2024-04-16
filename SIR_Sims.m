%SIR_Sims

function SIR_Sims(option,plottype)

DArray = [];
propWithoutCovidArray = [];

%% Initial Infections
if strcmp(option,'Inital Infections')
    iArray=[1:10:500];
    for i=1:50
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(2000-index,index,0,0.02,30, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Initially Vaccinated
if strcmp(option,'Initally Vaccinated')
    iArray=[0:40:1800];
    for i=1:46
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(1800-index,200,index,0.02,30, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Masking Policies
if strcmp(option,'Masking Policies')
    iArray=[0.0:0.001:0.05];
    for i=1:51
        index=iArray(i);
        %S,I,V,alpha,BintPerDay, baseQuarRate, testFreq, regTesting, baseVaccRate, vaccRollout, clinics, rounding, days, recovRate, immLoss, deathrate)
        [~, D, propWithoutCovid]=Test_B(1800,200,0,index,30, 0, 7, false, 0, 0, false, true, 365 , .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Distancing Policies
if strcmp(option,'Distancing Policies')
    iArray=[0.0:1:50];
    for i=1:51
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, index, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Test Everyone
if strcmp(option,'Test Everyone')
    iArray=[0.0:1:50];
    for i=1:51
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, index, true, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Quarantines without Testing
if strcmp(option,'QuarNoTest')
    iArray=[0.0:0.01:0.5];
    for i=1:51
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, index, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Vaccine Mandate + Testing
if strcmp(option,'Vaccine Mandate + Testing')
    for i=1:200
    [~, D, propWithoutCovid]=Test_B(100,200,1700,0.02, 30, 0, i-1, true, 0, 0, true, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Recovery Rate
if strcmp(option,'Recovery Rate')
    iArray=[0.0:0.01:0.35];
    for i=1:36
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, index, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Immunity Loss
if strcmp(option,'Immunity Loss')
    iArray=[0.0:0.001:0.05];
    for i=1:51
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .07, index, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Death Rate
if strcmp(option,'Death Rate')
    iArray=[0.0:0.00004:0.002];
    for i=1:51
        index=iArray(i);
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .07, .01, index);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end


%% Outputs
if strcmp(plottype, 'Deaths')
    Deaths=DArray';
    indexes=iArray';

    plot(indexes,Deaths)
elseif strcmp(plottype, 'Covid_Free')
    Covid_Free=propWithoutCovidArray';
    indexes=iArray';

    plot(indexes,Covid_Free)
else
    error('You did not plot anything!')
end
    
