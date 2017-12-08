clc ; clear all;

v_m = -60;
c_m = 1;
g_na = 120;
g_k = 36;
g_l = 0.3;
e_na = +155 + v_m;
e_k = -12 + v_m;
e_l = 10.598 + v_m;

%I_s = .2;
v_m = 0;
alpha_n = (0.01 *( 10 - v_m )) / (exp((10 - v_m)/10)-1);
beta_n = 0.125*exp(-(v_m) /80);

alpha_h = 0.07*exp(-v_m/20);
beta_h = 1/ (exp((30 - v_m)/10)+1);

alpha_m = (0.1*(25 - v_m)) / ( exp(0.1*(25-v_m))-1);
beta_m = 4.0 * exp(-v_m/18);

n(1) = alpha_n / (alpha_n+beta_n);
m(1) = alpha_m / (alpha_m+beta_m);
h(1) = alpha_h / (alpha_h+beta_h);

del_t = .01;
v_m = -60;
V_m(1) = v_m;
for i = 1:10000
    
    if (i > 2000 && i < 2022 || i > 7000 && i < 7050)
        I_s = 20;
    else
        I_s = 0;
    end
    
    del_n = del_t * ((alpha_n *(1 - n(i))) - (beta_n * n(i)));
    del_m = del_t * ((alpha_m *(1 - m(i))) - (beta_m * m(i)));
    del_h = del_t * ((alpha_h *(1 - h(i))) - (beta_h * h(i)));
    
    n(i+1) = n(i) + del_n;
    m(i+1) = m(i) + del_m;
    h(i+1) = h(i) + del_h;
    
    g_k1 = n(i)^4 * g_k;
    g_na1 = m(i)^3 * h(i) * g_na;
    
    I_k = g_k1 * (v_m - e_k);
    I_na = g_na1 * (v_m - e_na);
    I_l = g_l * (v_m - e_l);
    
    if (I_s > 0)
        
        del_v = ( del_t / c_m) * ( I_s -( I_na + I_k + I_l ) );
        
    else
        
        del_v = ( del_t / c_m) * ( -(I_na + I_k + I_l) );
    end
    v_m = v_m + del_v
    
    V_m(i+1) = v_m;
    
    
    
    alpha_n = (0.01 *( 10 - (v_m + 60 ))) / (exp((10 - (v_m + 60))/10)-1);
    beta_n = 0.125*exp(-(v_m + 60) /80);
    
    alpha_h = 0.07*exp(-(v_m + 60)/20);
    beta_h = 1/ (exp((30 - (v_m + 60))/10)+1);
    
    alpha_m = (0.1*(25 - (v_m + 60))) / ( exp(0.1*(25-(v_m + 60)))-1);
    beta_m = 4 * exp(-(v_m + 60)/18);
    
end

tim = del_t*(1:10000+1);
subplot(2,3,1);
plot(tim,V_m,tim,n,tim,m,tim,h,'--');
subplot(2,3,2);

plot(tim,n,tim,m,'--',tim,h);
xlabel('ms ========>');
subplot(2,3,3);
plot(tim,V_m);

title('Variation Of m, n and h');

legend('n','m','h');
ylabel('mV');
figure,
plot(tim,V_m);
figure,
plot(tim,n,tim,m,'--',tim,h);
xlabel('ms ========>');
legend('n','m','h');







