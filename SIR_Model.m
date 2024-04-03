%% SIR(V)(D) Model
%Description
%

rounding=false;

S=1900;
I=100;
R=0;
Q=0;
V=0;
D=0;
totalPop=S+I+R+Q; %doesn't include dead

days=600; %length of sim

alpha=.2; %rate of disease spread?? (dS, dI)

%Death
deathrate=0.00115;
%Quarantine
quarRate=0;
%Vaccine
efficacy=0.9;
vaccRate=0.001;
vaccRollout=365;

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

    if i>vaccRollout
        if ~rounding
        % NOT rounding!
        dS =-S*I*alpha/totalPop +R*.01 -vaccRate*S;
        dI = S*I*alpha/totalPop -I*.1 -I*deathrate -I*quarRate +V*I*alpha*(1-efficacy)/totalPop;
        dR = I*.1 -R*.01 +Q*.1 -vaccRate*R/2;
        dQ = I*quarRate -Q*.1 -Q*deathrate;
        dV = vaccRate*R/2 +vaccRate*S -V*I*alpha*(1-efficacy)/totalPop;
        dD = deathrate*(I+Q);
        else
        % rounding!
        dS =-round(S*I*alpha/totalPop) +ceil(R*.01)- round(vaccRate*S);
        dI = round(S*I*alpha/totalPop) -ceil(I*.1) -round(I*deathrate) -round(I*quarRate) +round(V*I*alpha*(1-efficacy)/totalPop);
        dR = ceil(I*.1) -ceil(R*.01) +ceil(Q*0.1) -round(vaccRate*R/2);
        dQ = round(I*quarRate) -ceil(Q*.1) -round(Q*deathrate);
        dV = round(vaccRate*R/2) +round(vaccRate*S) -round(V*I*alpha*(1-efficacy)/totalPop);
        dD = round(deathrate*I) + round(deathrate*Q);
        end
    else
        dV=0;
        if ~rounding
        % NOT rounding!
        dS =-S*I*alpha/totalPop +R*.01;
        dI = S*I*alpha/totalPop -I*.1 -I*deathrate -I*quarRate;
        dR = I*.1 -R*.01 +Q*.1;
        dQ = I*quarRate -Q*.1 -Q*deathrate;
        dD = deathrate*(I+Q);
        else
        % rounding!
        dS =-round(S*I*alpha/totalPop) +ceil(R*.01);
        dI = round(S*I*alpha/totalPop) -ceil(I*.1) -round(I*deathrate) -round(I*quarRate);
        dR = ceil(I*.1) -ceil(R*.01) +ceil(Q*0.1);
        dQ = round(I*quarRate) -ceil(Q*.1) -round(Q*deathrate);
        dD = round(deathrate*I) + round(deathrate*Q);
        end
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