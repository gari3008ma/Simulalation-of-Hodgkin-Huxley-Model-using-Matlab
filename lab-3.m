an = (0.01.*(10-(vm)))./(exp((10-vm)./10)-1);
bn = (0.125).*exp((-vm)./80);
subplot(3,3,1)
plot(tim,an,'r',tim,bn,'b')
xlabel('time') % x-axis label
ylabel('an and bn') 
am=(01.*(25-vm))./(exp(0.1.*(25-vm))-1);
bm=4.*exp((-vm)./18);
subplot(3,3,2)
plot(tim,am,'r',tim,bm,'b')
xlabel('time') % x-axis label
ylabel('am and bm') 
ah=0.07.*exp((-vm)./20);
bh=1./(exp((30-vm)./10)+1);
subplot(3,3,3)
plot(tim,ah,'r',tim,bh,'b')
xlabel('time') % x-axis label
ylabel('ah and bh') 
for i=1:length(tim)-1
    dt(i)=tim(i+1)-tim(i);
end
anz=(0.01*(10-(-60)))/(exp((10+60)/10)-1);
bnz=(0.125)*exp((-60)/80);
n(1)=anz/anz+bnz;
amz=(01*(25+60))/(exp(0.1*(25+60))-1);
bmz=4*exp(60/18);
m(1)=amz/(amz+bmz);
ahz=0.07*exp(60/20);
bhz=1/(exp((90/10)+1));
h(1)=ahz/(ahz+bhz);
for i=1:length(vm)-1
n(i+1)=n(i)+((an(i).*(1-n(i)-bn(i).*n(i))).*dt(i));
m(i+1)=m(i)+((am(i).*(1-m(i)-bm(i).*m(i))).*dt(i));
h(i+1)=h(i)+((ah(i).*(1-h(i)-bh(i).*h(i))).*dt(i));
end
subplot(3,3,4)
plot(tim,n,'r')
xlabel('time') % x-axis label
ylabel('n') 
subplot(3,3,5)
plot(tim,m,'b')
xlabel('time') % x-axis label
ylabel('m') 
subplot(3,3,6)
plot(tim,h,'g')
xlabel('time') % x-axis label
ylabel('h')