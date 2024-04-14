%SIR_Sims

function SIR_Sims(option)

DArray = [];
propWithoutCovidArray = [];

%% Initial Infections
if strcmp(option,'Inital Infections')
    for i=1:500
        [~, D, propWithoutCovid]=Test_B(2000-i,i,0,0.02,30, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Initially Vaccinated
if strcmp(option,'Initally Vaccinated')
    for i=1:200
        [~, D, propWithoutCovid]=Test_B(1800-(i*9),200,i*9,0.02,30, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Masking Policies
if strcmp(option,'Masking Policies')
    for i=1:200
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02-(i*0.00025),30, 0, 7, false, 0, 0, false, true, 365 , .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Distancing Policies
if strcmp(option,'Distancing Policies')
    for i=1:200
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 50-i/4, 0, 7, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Test Everyone
if strcmp(option,'Test Everyone')
    for i=1:200
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, i-1, true, 0, 0, false, true, 365, .07, .01, 0.00115);
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

%% Vaccine Mandate + Testing
%if strcmp(option,'Vaccine Mandate + Testing')
%    for i=1:200
%        [~, D, propWithoutCovid]=Test_B(100,200,1700,0.02, 30, 0, i-1, true, 0, 0, true, true, 365, .07, .01, 0.00115);
%        DArray=[DArray, D];
%        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
%    end
%end

%% Recovery Rate
if strcmp(option,'Recovery Rate')
    for i=0:200
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .06+i*0.0001, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Immunity Loss
if strcmp(option,'Immunity Loss')
    for i=0:200
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .07, i*0.0001, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end

%% Death Rate
if strcmp(option,'Death Rate')
    for i=1:200
        [~, D, propWithoutCovid]=Test_B(1800,200,0,0.02, 30, 0, 0, false, 0, 0, false, true, 365, .07, .01, 0.00115);
        DArray=[DArray, D];
        propWithoutCovidArray=[propWithoutCovidArray, propWithoutCovid];
    end
end


%% Outputs
    Deaths=DArray';
    Covid_Free=propWithoutCovidArray';

    plot(Deaths)
