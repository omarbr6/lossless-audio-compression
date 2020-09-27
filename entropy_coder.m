function [ nbits ] = entropy_coder( flat_r )
 
nbits=0;
Fs=44100;
N=0.03*Fs; %30ms 

%For each frame of the residue the mean value is calculated, which is 
%quantized with a logarithmic quantizer, obtaining an index that is 
%dequantized locally.
mean=sum(abs(flat_r))/N;
index=floor(log2(mean)+0.5);
mean_d=2^index;

%For each sample we calcuate the probability and the bits to quantify it
for i=1:length(flat_r)
    x(i)=round(flat_r(i)/mean_d+0.5);
    prob = gaussmf(double(x(i)),[0.6 -0.1]);
    nbits=-log2(prob)+nbits;
    
end


nbits=int16(nbits);

end

