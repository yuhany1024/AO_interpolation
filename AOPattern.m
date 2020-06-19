function [pattern,convergence] = AOPattern(xSlope,ySlope,N, iterationNum,pixelNum_subregion)
%using the txt phaseReconstruction file to recover the phase distribution
%on SLM. The returned pattern is a wraped gray level image.
if nargin==0
    filePath='6_dz50.txt';
    N=9;
    [xSlope,ySlope] = readPhaseReconstruction(filePath,N);
    iterationNum=300;
    pixelNum_subregion=50;
end

dx=pixelNum_subregion;
[phase_center,convergence] = phaseRecontruction(xSlope,ySlope,N,dx, iterationNum);

pattern=zeros(N*pixelNum_subregion);
for i=1:N
    for j=1:N
        y1=(i-1)*pixelNum_subregion+1;
        y2=i*pixelNum_subregion;
        x1=(j-1)*pixelNum_subregion+1;
        x2=j*pixelNum_subregion;
        
        pattern(y1:y2,x1:x2)=rampGen(pixelNum_subregion,xSlope(i,j),ySlope(i,j));
        pattern(y1:y2,x1:x2)=pattern(y1:y2,x1:x2)-pattern(round((y1+y2)/2),round((x1+x2)/2))+phase_center(i,j);
    end
end





end

