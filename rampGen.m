function rampImg = rampGen(rampSize,xSlope,ySlope)
%Generate a ramp image.The slope is the gray level gradient putting on SLM.
%rampSize is the pixel number N
%rampImg is wraped gray level pattern(double) (N*N matrix).
rampImg=zeros(rampSize);

for i=1:rampSize
    for j=1:rampSize
        if i==1&&j==1
            rampImg(i,j)=0;
        elseif i==1&&j~=1
            rampImg(i,j)=rampImg(i,j-1)+xSlope;
        elseif i~=1
            rampImg(i,j)=rampImg(i-1,j)+ySlope;
        end
        
    end
end


end

