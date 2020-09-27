function [ pred_r_p ] = post_processor( flat_r,J_q,lsb )

%number of downshifts applied to each residue
pred_r_p=flat_r;

for i=1:length(J_q)
    num=0;
    for j = i+1:length(J_q)
        num=num+log2(abs(1/(1-J_q(j)^2)))+0.5;
    end

n=floor(num);

%up-shift
pred_r_p(i)=bitshift(flat_r(i),n)+lsb;

end

end

