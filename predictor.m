function [ pred_r,J_q ] = predictor( signal )

p=20;
min_J=-pi/2;
max_J=pi/2;
B=10;

%For each frame we apply a LPC with PARCOR coefficients calculated with the Levinson-Durbin algorithm
    r_t=xcorr(signal,signal);  %Symetric correlation. 
    r=r_t(length(r_t)/2:end); %Choosing the axys.
    
    [a_t,e,k]=levinson(r,p); %k=coef. parcor e= pot. prediction error p=20,30

    %Parkor conversion 
    %Partition quantification+Uniform quantification 
   for i=1:length(k) 
    J(i)=asin(k(i));
   end
    signal_n=(J-min_J)/(max_J-min_J);
    index=min(floor(signal_n*2^B),2^B-1);
    
%The same quantized PARCORs are dequantized and converted to coef to apply linear predictor. 
    %Desquantization of the parkors.
    for j=1:length(index)
        J_q(j)=index(j)*((max_J-min_J)/2^B)+min_J+((max_J-min_J)/2^B)/2;
        k_dq(j)=sin(J_q(j));
    end
    
    %Parkors to LPC coefficients: k -> a
    a=rc2poly(k_dq);
    
    %Lpc 
    pred_t = filter([0 -a(2:end)],1,signal);
    pred= int16(pred_t);

    pred_r=signal-pred;
    
end


