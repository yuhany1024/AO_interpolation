function [xSlope,ySlope] = readPhaseReconstruction(filePath,N)
%read a txt file that contains the phase gradients of N*N segments.
%return two N*N matrics xSlope & ySlope, which are supposed to be 9*9
xSlope=zeros(N,N);
ySlope=zeros(N,N);

file=readtable(filePath,'Delimiter',{',','\t'});
for i=1:N
    for j=1:N
        xSlope(i,j)=table2array(file(i,3*(j-1)+1));
        ySlope(i,j)=table2array(file(i,3*(j-1)+2));
    end
end


end

