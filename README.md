For MAT 306.

[popArray, D, propWithoutCovid]=SIR_Model(S,I,V,alpha,BintPerDay, baseQuarRate, testFreq, regTesting, baseVaccRate, vaccRollout, clinics, rounding, days)

- S=susceptible population
- I=infected population
- V=vaccinated population
- alpha=transmissibility
- BintPerDay=number of interactions for the average person per day
- baseQuarRate=base quarantine rate
- testFreq=how often mandatory Covid testing occurs
- regTesting=True/False, whether mandatory Covid testing occurs
- baseVaccRate=base vaccination rate
- vaccRollout=day that vaccine is available
- clinics=True/False, whether vaccine clinics are held or not
- rounding=True/False, whether rounding is used in the model or not
- days=length of simulation

SIR_sims()
- Comment out different sections to produce different graphs simulating changes in variables as desired. Outputs Annual Deaths graph or Covid Free graph.

[shandle,chandle] = stackedPlots(A)
- From Prof. Blanchard
