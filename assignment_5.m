clc ; clear all;

a = 0.0238;
R_i = (34.5 * 1000 )/ ( 3.14 * a * a);
C_m = 1 * 2*a* 3.14 * 0.1 ;

g_na = 120;
e_na = 115 - 60;

g_k = 36;
e_k = -12 - 60;

g_l = 0.3;
e_l = 10.598 - 60;

del_x = 0.1;
v_m(1,1) = 0;

alpha_n = (0.01 *( 10 - v_m(1,1) )) / (exp((10 - v_m(1,1))/10)-1);
beta_n = 0.125*exp(-(v_m(1,1)) /80);

alpha_h = 0.07*exp(-v_m(1,1)/20);
beta_h = 1/ (exp((30 - v_m(1,1))/10)+1);

alpha_m = (0.1*(25 - v_m(1,1))) / ( exp(0.1*(25-v_m(1,1)))-1);
beta_m = 4.0 * exp(-v_m(1,1)/18);

n(1:10000,1:11) = 0;
m(1:10000,1:11) = 0;
h(1:10000,1:11) = 0;

n(1,1:11) = alpha_n / (alpha_n + beta_n);
m(1,1:11) = alpha_m / (alpha_m + beta_m);
h(1,1:11) = alpha_h / (alpha_h + beta_h);

v_m(1:10001,1:11) = -60;
v_m(1,1:11) = -60;

del_t = 0.0001 * 6;

i_p = 0;
for i = 1:10000
    
    for j = 2:10
        
        if (j == 4 && i > 4000);
            I_s = 20
            
        else
            I_s = 0;
          
        end
        
       % I_m(i,j) = (1 / ((2*3.14*a*0.1)*(R_i))) * ((((v_m(i,j-1) + 60) - 2*( v_m(i,j) + 60) + (v_m(i,j+1)+60))/del_x^2) - (R_i * i_p)) + I_s;
       
       I_m(i,j) = (1 / ((2*3.14*a*0.1)*(R_i))) * ((((v_m(i,j-1) + 60) - 2*( v_m(i,j) + 60) + (v_m(i,j+1)+60))/del_x^2) ) + I_s;
        
        g_k1 = n(i,j)^4 * g_k;
        g_na1 = m(i,j)^3 * h(i,j) * g_na;
        
        I_k = g_k1 * (v_m(i,j) - e_k);
        I_na = g_na1 * (v_m(i,j) - e_na);
        I_l = g_l * (v_m(i,j) - e_l);
         
        I_ions =(I_k + I_na + I_l);
        
        del_v(i,j) = (del_t / C_m) * (I_m(i,j) - I_ions);
        
        v_m(i+1,j) = v_m(i,j) + del_v(i,j);
        
        del_n(i,j) = del_t * ((alpha_n *(1 - n(i,j))) - (beta_n * n(i,j)));
        del_m(i,j) = del_t * ((alpha_m *(1 - m(i,j))) - (beta_m * m(i,j)));
        del_h(i,j) = del_t * ((alpha_h *(1 - h(i,j))) - (beta_h * h(i,j)));
        
        
        n(i+1,j) = n(i,j) + del_n(i,j);
        m(i+1,j) = m(i,j) + del_m(i,j);
        h(i+1,j) = h(i,j) + del_h(i,j);
        
        
        alpha_n = (0.01 *( 10 - (v_m(i,j) + 60 ))) / (exp((10 - (v_m(i,j) + 60))/10)-1);
        beta_n = 0.125*exp(-(v_m(i,j) + 60) /80);
        
        alpha_h = 0.07*exp(-(v_m(i,j) + 60 )/20);
        beta_h = 1/ (exp((30 - (v_m(i,j)+ 60 ))/10)+1);
        
        alpha_m = (0.1*(25 - (v_m(i,j) + 60))) / ( exp(0.1*(25-( v_m(i,j) + 60 )))-1);
        beta_m = 4.0 * exp(-(v_m(i,j) + 60 )/18);
        
       
    end
    
end

tim = del_t * (1:10001);

subplot(2,3,1);
plot(tim,v_m,tim,n,tim,m,tim,h,'--');
xlabel('ms ========>');


subplot(2,3,2);

    title('Variation Of m, n and h');
plot(tim,n,tim,m,'--',tim,h);
 xlabel('ms ========>');
  legend('n','m','h');   
 
 ylabel('probability of n,m,h');
 
 subplot(2,3,3);
  ylabel('mV');
 plot(tim,v_m);
 xlabel('ms ========>');
 
    figure,
    plot(tim,v_m);
    
    figure,
    plot(tim,n,tim,m,'--',tim,h);
 xlabel('ms ========>');
  legend('n','m','h');