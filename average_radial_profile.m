function [rd, radial_profile] = average_radial_profile(I)
% Calculate average radial profile from 0 to N/2 (without edges). 
[Nr, Nc] = size(I);
Cr = ceil(Nr/2);
Cc = ceil(Nc/2);
Nt = max(ceil(Nr/2), ceil(Nc/2));
radial_profile = zeros(Nt, 1);
count = zeros(Nt, 1);
rd = zeros(Nt, 1);

for c = 1 : Nc
  for r = 1 : Nr
      rad = sqrt((r - Cr) ^ 2 + (c - Cc) ^ 2);
      i = 1 + ceil(rad);
           if i <= Nt  
            radial_profile(i) = radial_profile(i) + I(r, c);
            count(i) = count(i) + 1;
            rd(i) = i;
           end
  end
end
radial_profile = radial_profile ./ count;
end

