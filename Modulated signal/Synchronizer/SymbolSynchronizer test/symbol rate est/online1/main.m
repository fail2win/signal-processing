M=4;%???��??????M??????2*pi/M?????????????��??��??????����????????��??????��?????

%?��??��????????����???????N????????????????��??��????��???��??��??????

j=32;%????????

x=[0 2 1 3 0 2 0 1 3 2 0 1 1 3 1 0 0 2 0 1 3 2 0 1 3 0 2 0 1 3 2 0];%%randint(1,j);

fc=10000;

fd=1000;

fs=200000;

[sn,t]=modulate(x,fc,fd,fs,'psk',M);

s=awgn(sn,7,'measured','db');%?????��

t=1/fs:1/fs:j/fd;

N=7;%???����???????

ls=length(s);

[c,l]=wavedec(s,N,'db5');

figure(1);

subplot(N+2,1,1);plot(t,s);

aN=wrcoef('a',c,l,'db5',N);

subplot(N+2,1,2);plot(aN);

for i=1:ls

    if abs(c(i))<0.64

        c(i)=0;

    end

end

for i=1:N

    di=wrcoef('d',c,l,'db5',N+1-i);

    subplot(N+2,1,2+i);plot(di);

end

 

 

 

r = xcorr(di);

ls1=length(r);

% d(ls1-1)=0;

% for i=1:ls1-1

%     d(i)=r(i+1)-r(i);

% end

R=1;

figure(2);

% subplot(R,1,1);plot(r);xlabel('???????��????��??��??');

subplot(R,1,1);plot(abs(r));xlabel('???????��????��??��????????');

for i=1:ls1-1

    if(r(i)==max(r))   

        mr=i 

    end

end

i=mr-5;

while(abs(r(i))<2.7)

    i=i-1;

end

Rs1=i

i=mr+5;

while(abs(r(i))<2.7)

    i=i+1;

end

Rs2=i  

Rs=(Rs2-Rs1)/2