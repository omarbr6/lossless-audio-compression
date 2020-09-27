function [ signal ] = reconstruction( pred_r,J_q )

min_J=-pi/2;
max_J=pi/2;
B=10;

%Disquantification of the parcor
 for j=1:length(J_q)
     k_dq(j)=sin(J_q(j));
 end

%parcor to coef a
a_t=rc2poly(k_dq);
a=-a_t(2:end);

%Lpc

signal = zeros(length(pred_r),1);
  signal(1) = pred_r(1);
  for i=2:length(pred_r)
      pred = 0;
      if i<=length(a)
        for j=1:i-1
             pred = pred + a(j) * signal(i-j);
        end
        signal(i) = pred_r(i) + pred;
      else
        for j=1:length(a)
            pred = pred + a(j) * signal(i-j);
        end
        signal(i) = pred_r(i) + pred; 
      end
  end

end

