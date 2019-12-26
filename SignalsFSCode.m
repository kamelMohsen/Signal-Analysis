%%Kamel Mohsen Kamel
%%01097000365
%%kamelmohsen99@yahoo.com
clc
clear
%%The following lines allows the user to choose the signal he wants 
disp('Choose a signal:');
disp('1- SawTooth.');
disp('2- Square.');
disp('3- RectPulse.');
disp('4- TriPulse.');
disp('5-Custom Function.');
UserInput= input('');
%%Intialization
t = linspace(-4,4,10000);
FS = 0; 
disp('Enter number of harmonics needed:');
H = input('');
%%If Condition for each signal
    if UserInput == 1
    
        InputName = ' SawTooth ';
        W = (2*pi);
        OriginalSignal = sawtooth(W*t);%Sawtooth
        
   
    elseif UserInput == 2
    
        InputName = ' Square ';
        W = (2*pi);
        OriginalSignal = square(W*t);%Square
      
    
    elseif UserInput == 3
    
        InputName=' RectPulse ';
        OriginalSignal = rectangularPulse(-2,2,t);%SquarePulse
        FS = FS+(4/12);%%Adding DC Term
        W = pi/6;
    
    elseif UserInput == 4
         
        InputName = ' TriPulse ';
        OriginalSignal = triangularPulse(t);%TriPulse
        FS = FS+(1/12);%%Adding DC Term
        W = pi/6;
        
    elseif UserInput == 5
      
        a= input('enter the beginning of the period:');
        b= input('enter the end of the period:');
        f=input('enter the function :','s');
        InputName = f;
        s1='integral(@(t)(exp(-1i.*K.*W.*t)).*';
        s2= strcat(s1,f);
        s3= ',a,b)';
        s4=strcat(s2,s3);
        Tnode=b-a; 
        W = (2*pi/(Tnode));
        t = linspace(a,b,10000);
        OriginalSignal = eval(f);

    end
%%Calculating the FS
for K=-H:1:H
 
    if(K==0 && UserInput~=5 )             
        continue;
    end
    
  
if UserInput == 1
    AK = (-2/((1i*K*W)));%SawTooth
elseif UserInput == 2
    AK = ((1)/(K*pi*1i))*(1-exp(-K*pi*1i));%Square
elseif UserInput == 3
     
     AK = (( (-exp(-2*1i*K*W) + exp(2*1i*K*W)) / (12*1i*K*W) ) ) ;%RectPulse
elseif UserInput == 4
     AK = (( (exp(-1i*K*W) + exp(1i*K*W) - 2 ) / (12*(1i*K*W)^2 )) );%TriPulse
elseif  UserInput == 5
     lolo = eval(s4);
     AK=(1/Tnode).*lolo;
end

    
    XOFT = AK*exp(W.*1i.*K.*t);                
    FS = FS + XOFT;                              
 
end
%%Plotting
plot(t,OriginalSignal,'LineWidth', 2), hold on;
plot(t, FS,'LineWidth', 2);
grid on;
xlabel('t');
ylabel('f(t)');
title(strcat('Fourier Series of the ', InputName , ' wave function with n=', int2str(H), ' harmonics.' ));