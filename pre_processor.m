function [flat_r,lsb,signe] = pre_processor( pred_r,J_q)

flat_r=pred_r;
lsb=0;
signe=0;

for r=1:length(pred_r)
    if flat_r(r)~=0
        signe=signe+1;
    end
end

for i=1:length(J_q)
    %number of downshifts applied to each residue
    num=0;
    for j = i+1:length(J_q)
        num=num+log2(abs(1/(1-J_q(j)^2)))+0.5;
    end

n=floor(num);


%down-shift
flat_r(i)=bitshift(pred_r(i),-n);

%Calcul lSB
lsb=lsb+n;

%calcular numero de mostres diferents de 0 perque s'haurà de transmetre el
%signe


end
end


