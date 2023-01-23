function [position,isterminal,direction] = odeEventFun(t,y)
position = (norm(y(1:3))-6378137-15000 < 0);
isterminal = 1;
direction = 0;
end