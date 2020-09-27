
[x,Fs]=audioread('queen.wav','native'); %buscar audio de fs=48k
M=length(x);
N=0.03*Fs; %30ms 
f=0;


nbits_total=0;
signe_total= 0;
lsb_total=0;
   

for i=1:(floor(M/N)+1)
    s=f+1; 
    f=f+N;
    if f>M
       f=M;       
    end
    samples=[s,f];
    [x,Fs]=audioread('queen.wav',samples,'native');
    left=x(:,1); 
    n=length(x);
    right=x(:,2);
    if length(left)<N 
      left=horzcat(left',zeros(1,N-length(left)));
      right=horzcat(right',zeros(1,N-length(right)));
    end 
    
    %gràfica senyal d'entrada
%     subplot(2,1,1)
%     plot(left);
    
    %predicció
    [pred_r_l,k_q_l]=predictor(left);
    [pred_r_r,k_q_r]=predictor(right);
    
    %pre-processor
%     [flat_r_l,lsb_l,signe_l] = pre_processor( pred_r_l,k_q_l );
%     [flat_r_r,lsb_r,signe_r] = pre_processor( pred_r_r,k_q_r );
     
    %entropy_coder
%     [ nbits_l ] = entropy_coder( flat_r_l );
%     [ nbits_r ] = entropy_coder( flat_r_r );
%     
    %post_processor
%     [ pred_r_l ] = post_processor( flat_r_l,k_q_l,lsb_l );
%     [ pred_r_r ] = post_processor( flat_r_r,k_q_r,lsb_r );
%     
    %reconstructor
    [l]=reconstruction(pred_r_l,k_q_l);
    [r]=reconstruction(pred_r_r,k_q_r);
    
    %ajuntem els frames
    if i==floor(M/N)+1
       l=l(1:n);
       r=r(1:n);
    end

     left_r(s:f)=l';
     right_r(s:f)=r';
     
     
     nbits_total=nbits_total+nbits_l+nbits_r;
     signe_total= signe_total+signe_l+signe_r;
     lsb_total=lsb_total+lsb_l+lsb_r;
   
       
end
audio=cat(1,left_r,right_r);
audio=int16(audio);
audiowrite('reconstructed.wav',audio',44100);

