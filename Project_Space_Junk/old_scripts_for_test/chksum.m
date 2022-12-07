function result = chksum(str)
result = false; c = 0;

for k = 1:68
if str(k) > '0' && str(k) <= '9'
  c = c + str(k) - 48;
elseif str(k) == '-'
  c = c + 1;
end
end

if mod(c,10) == str(69) - 48
result = true;
end
end