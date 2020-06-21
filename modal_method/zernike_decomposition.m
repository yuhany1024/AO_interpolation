function [out1,out2,xmatrix] = zernike_decomposition(AOPattern,ZernikeModeN,mask)
%AOPattern is wraped:0-255
%return: (double) unwraped gray level
%out1 is the 3 dimensional data cube of the n Zernike polynomials requested [:,:,n]
%out2 are the coefficients used.
%xmatrix: zernike patterns with coefficent=1
if nargin==0
    AOPattern=double(imread('E:\defocus\20190723_25x_new_pattern_aberration\beadsAO\-60\-60_SLM-ramp-overlay.png'));
    AOPattern=AOPattern(7:506,7:506);
    
    ZernikeModeN=45;
    mask=ones(size(AOPattern));
    mask(1:75,1:75)=0;
    mask(end-74:end,1:75)=0;
    mask(1:75,end-74:end)=0;
    mask(end-74:end,end-74:end)=0;

    
    AOPattern=AOPattern*255;
end

AOPattern=double(AOPattern);
AOPhase=AOPattern/255*2*pi;   %phase:rad
AOPhase(mask==0)=nan;



AOPhase_unwrap=unwrap_phase(AOPhase);  %unwrap the AO pattern 
AOPhase_unwrap_gray=AOPhase_unwrap/2/pi*255; 


[out1,out2,xmatrix] = ZernikeCalc( 1:ZernikeModeN, AOPhase_unwrap_gray, mask, 'SQUARE');


end

