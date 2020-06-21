function [phase,convergence] = phaseRecontruction(xSlope,ySlope,N,dx, iterationNum)
%The olgorithm will iterate iterationNum;
%The pattern has N*N subregions
%Slope is the gray level gradient putting on SLM.  xSlope and ySlope are
%both N*N matrics
%dx: how many pixels between the centers of two subregions. 
%phase is the phase of the center of each subregion (the unit is wraped
%gray level). It's a N*N matrics. 
%reference: W.H.southwell(1980): wavefront estimation from wavefront slope
%measurement

if(size(xSlope,1)~=N||size(ySlope,1)~=N)
    error("The size of the input are inconsistent!");
end


g=4*ones(N,N);
for j=1:N
    for k=1:N
        if j==1||j==N
        	if k==1||k==N
                g(k,j)=2;
            end 
        end
        if j==1||j==N
            if k~=1&&k~=N
                g(k,j)=3;
            end
        end
        if k==1||k==N
            if j~=1&&j~=N
                g(k,j)=3;
            end
        end       
    end
end


b=zeros(N,N);
xSlope_temp=zeros(N+2,N+2);
ySlope_temp=zeros(N+2,N+2);
xSlope_temp(2:N+1,2:N+1)=xSlope;
ySlope_temp(2:N+1,2:N+1)=ySlope;

xSlope_temp(1,2:N+1)=-xSlope(1,:);
xSlope_temp(N+2,2:N+1)=-xSlope(N,:);
xSlope_temp(2:N+1,1)=-xSlope(:,1);
xSlope_temp(2:N+1,N+2)=-xSlope(:,N);

ySlope_temp(1,2:N+1)=-ySlope(1,:);
ySlope_temp(N+2,2:N+1)=-ySlope(N,:);
ySlope_temp(2:N+1,1)=-ySlope(:,1);
ySlope_temp(2:N+1,N+2)=-ySlope(:,N);

b=1/2*dx*(ySlope_temp(1:N,2:N+1)-ySlope_temp(3:N+2,2:N+1)+xSlope_temp(2:N+1,1:N)-xSlope_temp(2:N+1,3:N+2));


phase=zeros(N,N);
convergence=zeros(iterationNum,1);
phaseAvg=zeros(N,N);


%% Jacobi method

for i=1:iterationNum   
    phaseAvg_last_iter=phaseAvg; 
    phase_temp=zeros(N+2,N+2);
    phase_temp(2:N+1,2:N+1)=phase;
    phaseAvg=(phase_temp(2:N+1,3:N+2)+phase_temp(2:N+1,1:N)+phase_temp(3:N+2,2:N+1)+phase_temp(1:N,2:N+1))./g;
    phase=phaseAvg+b./g;

    convergence(i)=sum(sum((phaseAvg-phaseAvg_last_iter).^2));
end


end
