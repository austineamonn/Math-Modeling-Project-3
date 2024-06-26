%% SIR(V)(D) Model
%Description
%

function [popArray, D, propWithoutCovid]=SIR_Model(S,I,V,alpha,BintPerDay, baseQuarRate, testFreq, regTesting, baseVaccRate, vaccRollout, clinics, rounding)

if nargin<1
    rounding=true;

    S=1800;
    I=200;
    V=0;
end
R=0;
Q=0;
D=0;
totalPop=S+I+R+Q; %doesn't include dead

days=300; %length of sim

%Getting sick
if nargin<1
    alpha=.02; %rate of disease spread per interaction
    BintPerDay=30; %daily number of interactions?
end

%Recovering
recovRate=0.07;
immLoss=0.01;

%Death
deathrate=0.00115;

%Quarantine
if nargin<1
    regTesting=false;
    baseQuarRate=0;
    testFreq=7; %test all every __ days
end

%Vaccine
efficacy=0.9;
if nargin<1
    clinics=false;
    baseVaccRate=0.00;
    vaccRollout=0;
end

%% Susceptible
% From: Recovered
% To: Infected

%% Infected
% From: Susceptible
% To: Recovered + Dead

%% Recovered
% From: Infected
% To: Susceptible

%% Quarantined
% From: Infected
% To: Recovered + Dead

%% Vaccinated
%From: Susceptible, Recovered
%To: Infected

%% Dead
% From: Infected
% To: Nowhere, they're dead.

%% Over time!

popArray=[S I R Q V D];

covidless=0;

for i=1:days

    %vacc clinics
    if clinics
        if (i == 2 || i == 168 || i== 80 || i==236)
            vaccRate= .3;
        else
            vaccRate=baseVaccRate;
        end
    else
        vaccRate=baseVaccRate;
    end

    % if lots of ppl around are sick, get vaccinated
    %if I/(totalPop-D) > .02%???
    %    vaccRate=0.20;
    %else
    %    vaccRate=baseVaccRate;
    %end

    %10/10 superspreader
    %if i == 65
    %    intPerDay=100;
    %else
        intPerDay=BintPerDay;
    %end

    % Testing "weekly"
    if regTesting
        if mod(i,testFreq)==testFreq-1 || i==1 || i==2
            quarRate=.5;
        else
            quarRate=baseQuarRate;
        end
    else
        quarRate=baseQuarRate;
    end

    % Covid over break?!
    if i == 78 || i == 234
        if rounding
            brkCvd=round(.05*S);
        else
            brkCvd=.05*S;
        end
            S=S-brkCvd;
            I=I+brkCvd;
    elseif i == 165
        if rounding
            brkCvd=round(.1*S);
        else
            brkCvd=.1*S;
        end
        S=S-brkCvd;
        I=I+brkCvd;
    end

    if rounding
        % Rounding
        if i>vaccRollout
            dS =-round(S*I*alpha*intPerDay/(totalPop-D)) +ceil(R*immLoss)- round(vaccRate*S);
            dI = round(S*I*alpha*intPerDay/(totalPop-D)) -ceil(I*recovRate) -round(I*deathrate) -round(I*quarRate) +round(V*I*alpha*intPerDay*(1-efficacy)/(totalPop-D));
            dR = ceil(I*recovRate) -ceil(R*immLoss) +ceil(Q*recovRate) -round(vaccRate*R/2);
            dV = round(vaccRate*R/2) +round(vaccRate*S) -round(V*I*alpha*intPerDay*(1-efficacy)/(totalPop-D));
        else
            dS =-round(S*I*alpha*intPerDay/(totalPop-D)) +ceil(R*immLoss);
            dI = round(S*I*alpha*intPerDay/(totalPop-D)) -ceil(I*recovRate) -round(I*deathrate) -round(I*quarRate);
            dR = ceil(I*recovRate) -ceil(R*immLoss) +ceil(Q*recovRate);
            dV=0;
        end
        dQ = round(I*quarRate) -ceil(Q*recovRate) -round(Q*deathrate);
        dD = round(deathrate*I) + round(deathrate*Q);
    else
        % NOT Rounding 
        if i>vaccRollout
            dS =-S*I*alpha*intPerDay/(totalPop-D) +R*immLoss -vaccRate*S;
            dI = S*I*alpha*intPerDay/(totalPop-D) -I*recovRate -I*deathrate -I*quarRate +V*I*alpha*intPerDay*(1-efficacy)/(totalPop-D);
            dR = I*recovRate -R*immLoss +Q*recovRate -vaccRate*R/2;
            dV = vaccRate*R/2 +vaccRate*S -V*I*alpha*intPerDay*(1-efficacy)/totalPop;
        else
            dS =-S*I*alpha*intPerDay/(totalPop-D) +R*immLoss;
            dI = S*I*alpha*intPerDay/(totalPop-D) -I*recovRate -I*deathrate -I*quarRate;
            dR = I*recovRate -R*immLoss +Q*recovRate;
            dV=0;
        end
        dQ = I*quarRate -Q*recovRate -Q*deathrate;
        dD = deathrate*(I+Q);
    end

    S=S+dS;
    I=I+dI;
    R=R+dR;
    Q=Q+dQ;
    V=V+dV;
    D=D+dD;

    if I+Q==0
        covidless=covidless+1;
    end

    propWithoutCovid=covidless/days;
    popArray=[popArray; [S I R Q V D]];
end

plot(popArray)
legend('S','I','R','Q','V','D')

popArray=popArray';
