%% SIR(V)(D) Model
%Description
%

function popArray=SIR_Model()

rounding=true;

S=1800;
I=200;
R=0;
Q=0;
V=0;
D=0;
totalPop=S+I+R+Q; %doesn't include dead

days=365; %length of sim

%Getting sick
alpha=.02; %rate of disease spread per interaction
intPerDay=30; %daily number of interactions?

%Recovering
recovRate=0.07;
immLoss=0.01;

%Death
deathrate=0.00115;
%Quarantine
quarRate=0;
%Vaccine
efficacy=0.9;
baseVaccRate=0.0;
vaccRollout=0;

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

for i=1:days

    %vacc clinic
    if i == 10
        vaccRate=0.25;
    else
        vaccRate=baseVaccRate;
    end

    if rounding
        % Rounding
        if i>vaccRollout
            dS =-round(S*I*alpha*intPerDay/(totalPop-D)) +ceil(R*immLoss)- round(vaccRate*S);
            dI = round(S*I*alpha*intPerDay/(totalPop-D)) -ceil(I*recovRate) -round(I*deathrate) -round(I*quarRate) +round(V*I*alpha*intPerDay*(1-efficacy)/totalPop);
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

    popArray=[popArray; [S I R Q V D]];
end

plot(popArray)
legend('S','I','R','Q','V','D')

    popArray=[popArray; [S I R Q V D]];
end

plot(popArray)
legend('S','I','R','Q','V','D')

popArray=popArray';
