function pattern_expand = expandPattern(pattern,PixelNum)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

pattern=double(pattern);
pattern_expand=zeros(PixelNum,PixelNum);  %turn off part of the edges


edgeNum=(PixelNum-length(pattern))/2;
pattern_expand(edgeNum+1:edgeNum+length(pattern),edgeNum+1:edgeNum+length(pattern))=pattern;

dy1=pattern(2,:)-pattern(1,:);
for i=edgeNum:-1:1
    pattern_expand(i,edgeNum+1:edgeNum+length(pattern))=pattern_expand(i+1,edgeNum+1:edgeNum+length(pattern))-dy1;
end

dy2=pattern(end,:)-pattern(end-1,:);
for i=edgeNum+length(pattern)+1:1:(PixelNum)
    pattern_expand(i,edgeNum+1:edgeNum+length(pattern))=pattern_expand(i-1,edgeNum+1:edgeNum+length(pattern))+dy2;
end
    
dx1=pattern_expand(1:PixelNum,edgeNum+2)-pattern_expand(1:PixelNum,edgeNum+1);
for i=edgeNum:-1:1
    pattern_expand(1:PixelNum,i)=pattern_expand(1:PixelNum,i+1)-dx1;
end

dx2=pattern_expand(1:PixelNum,PixelNum-edgeNum)-pattern_expand(1:PixelNum,PixelNum-edgeNum-1);
for i=edgeNum+length(pattern)+1:1:(PixelNum)
    pattern_expand(1:PixelNum,i)=pattern_expand(1:PixelNum,i-1)+dx2;
end

pattern_expand=uint8(mod(pattern_expand,255));
    
    
    
end

