function [shandle,chandle] = stackedPlots(A)
% Input a mxn matrix A to get back two plots.
% The m rows of A are the function values of the m functions.
% The n columns of A are the steps of the function values.
% You get a filled, stacked, cummulative sum line plot so that the regions show the function value of each stacked up.
% The other plot has all functions plotted on the same axis

[m,n] = size(A);
C = cumsum(A);
color_str = 'brycmkg';

ind = 0:n-1;
xx=[ind, fliplr(ind)];

shandle = figure(1);
hold off

ww = zeros(1,n);
for func = 1:m
  yy = C(func,:);
  plot(ind, yy, color_str(func),'HandleVisibility','off');
  inbetween = [ww, fliplr(yy)];
  fill(xx,inbetween,color_str(func));
  hold on
  ww = yy;
end
xlim([ind(1),ind(end)])
ylim([0,max(max(C))])


chandle = figure(2);
hold off

for func = 1:m
  yy = A(func,:);
  plot(ind, yy,color_str(func),'LineWidth',2);
  hold on
end

xlim([ind(1),ind(end)])
ylim([0,max(max(C))])


