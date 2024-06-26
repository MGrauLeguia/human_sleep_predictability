function [dis,ix,iy,C,ind]=dtw_OE(C)
%%% takes the comulative C distance from dwt and calculates the open-ended
% version

%%% select the minim cum distance from at least one cycle %%%%
[dis,ind]=min(C(90:end,end));
%%%%% traceback for the indices %%%%
dis= dis/(89+ind);
%-------------------------------------------------------------------------
m = ind+89;
n = size(C,2);

% pre-allocate to the maximum warping path size.
ix = zeros(m+n,1);
iy = zeros(m+n,1);

ix(1) = m;
iy(1) = n;

i = m;
j = n;
k = 1;

while i>1 || j>1
  if j == 1
    i = i-1;
  elseif i == 1
    j = j-1;
  else
    % trace back to the origin, ignoring any NaN value
    % prefer i in a tie between i and j
    cij = C(i-1,j-1);
    ci = C(i-1,j);
    cj = C(i,j-1);
    i = i - (ci<=cj | cij<=cj | cj~=cj);
    j = j - (cj<ci | cij<=ci | ci~=ci);
  end
  k = k+1;
  ix(k) = i;
  iy(k) = j;
end

ix = ix(k:-1:1);
iy = iy(k:-1:1);




end