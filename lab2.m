
ti=linspace(0,2,200000);
for i=0:200000
    if(ti(i)==0 || ti(i)==0.01 || ti(i)==0.02)
                V=1;          
    else
        V=0;
    end
    a=(2500)*(V+0.1)*(10^3);
    b=(3500)*(V+0.1)*(10^3);
    A1 = 
     N0= -A1*exp(-(a+b)*ti)+((a/(a+b))*10^6);
end
plot(ti,N0)

