%
clc
clear



%%real_file test



%% Hilbert transformation  
%MSK;      a=s(1:1000);gen_data_file(s(1:1000),"MSK_signal.txt")   %s:MSK signal
%GMSK;     a=s;
OQPSK;    a=OQPSK_signal;%gen_data_file(OQPSK_signal(1:1000),"OQPSK_signal.txt")

%pi4DQPSK;  a=pi4DQPSK_signal;
%QAM;      a=MQAM;gen_data_file(MQAM(1:1000),"MQAM_signal.txt")
%a=a(1:1000);
a_h=hilbert(a);
%a_h=y(:,1)+y(:,2)*1i;
amp_a=abs(a_h);                                        %Envelope calculation from the Hilbert transform
m_a=mean(amp_a);

%% plot envelope
figure
plot(amp_a)
title('signal envelope:A_{n}')
a_n=amp_a/m_a;
a_cn=a_n-1;
figure
plot(a_cn)
title('signal envelope:A_{cn}')


%% plot phi
angle_a=angle(a_h);
close all
%% plot bispectrum
%figure
%plotBispectra(angle_a,fs,1,1);
%figure
%bispecd (angle_a,  512, 5,64,50);


angle_a=unwrap(angle_a);
for i=1:length(angle_a)
  angle_a(i)=mod(angle_a(i)-2*pi*fc*i/fs,2*pi);          %(5-295)
end
figure
angle_a=wrapToPi(angle_a);
plot(angle_a)
title('phase of signal \Phi(i)\in[-\pi,\pi]')
angle_a=angle_a-mean(angle_a);
figure%may be have problems
plot(angle_a)
title('\Phi_{NL}')
figure
plot(abs(angle_a))
title('|\Phi_{NL}|')
figure
plot(angle(s_complex))

%% 
gamma=MaxSpectralDensity(a)

%% 
%a=a_h;%%error 
%a=s;%QAM
a=s_complex;a_real=real(a);a_imag=imag(a);%OQPSK,pi/4DQPSK
%gen_data_file(a_real(1:1000),"OQPSK_signal_real.txt") ;gen_data_file(a_imag(1:1000),"OQPSK_signal_imag.txt") 
%gen_data_file(a_real(1:1000),"pi4DQPSK_signal_real.txt") ;gen_data_file(a_imag(1:1000),"pi4DQPSK_signal_imag.txt") 
%sl=awgn(sl,10,'measured');
%s=awgn(s,5,'measured');
%a=real(s);

C21=M_pq(a,2,1);
C40=M_pq(a,4,0)-3*M_pq(a,2,0)^2;
C42=M_pq(a,4,2)-M_pq(a,2,0).^2-2*M_pq(a,2,1).^2;
C63=M_pq(a,6,3)-6*M_pq(a,4,1).*M_pq(a,2,0)-9*M_pq(a,4,2).*M_pq(a,2,1)+18*M_pq(a,2,0).^2.*M_pq(a,2,1)+12*M_pq(a,2,1).^3;
%C63=M_pq(a,6,3)-6*M_pq(a,2,2).*M_pq(a,4,3)-9*M_pq(a,4,2).*M_pq(a,2,1)+18*M_pq(a,2,0).^2.*M_pq(a,2,1)+12*M_pq(a,2,1).^3;
C80=M_pq(a,8,0)-28*M_pq(a,2,0).*M_pq(a,6,0)-35*M_pq(a,4,0).^2+420*M_pq(a,2,0).^2.*M_pq(a,4,0)-630*M_pq(a,2,0).^4;
[C21 C40 C42 C63 C80]
C_f=abs(C80)/abs(C42)^2

%% ��ά��

d_delta=sum(abs(a(1:end-1)-a(2:end)));
d_2delta=0;
for ii=1:length(a)/2-1
    d_2delta=d_2delta+max([a(2*ii-1),a(2*ii),a(2*ii+1)])-min([a(2*ii-1),a(2*ii),a(2*ii+1)]);
end

N_1=d_delta*fs;
N_2=d_2delta*fs/2;
D_b=(log(N_1)-log(N_2))/log(2)




