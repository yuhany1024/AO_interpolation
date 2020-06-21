function [flag] = AO_interpolation_modal(filePath, dz, dz_interp, mask)
% This code uses modal approach to interpolate the AO Patterns at multiple
% image planes. The code help you get the interpolated AO patterns between
% measured patterns. It firstly decomposite the AO patterns by zernike
% modes. Then it interpolate the coeffiecients and reconstruct the
% interpolated AO patterns
% Input:
% 1. filePath: the folder path that stores the measured AO patterns(png files). The files will be read
% from the folder in order. The gray level of the images is between 0-255
% which can be mapped to 0-2pi phase(wrapped). Before the zernike
% decomposition, it firstly unwrap the patterns.
% 2. dz: how much defocus applied to the system for each measurement.
% 3. dz_interp: The defocus at which you want to get the interpolated
% patterns.
% 4. mask: Set the mask to be 0 on the unaccessible regions

if nargin == 0
    filePath = "./test";
    dz=-200:50:200; %focus shift in experiments
    dz_interp=-200:10:200;  %interpolation step
    mask = zeros(512,512);  %Set the mask to be 0 on the unaccessible regions
    mask(7:506,7:506) = 1;
    %     mask(1:75,1:75)=0;
%     mask(1:125,end-75:end)=0;
%     mask(end-125:end,1:75)=0;
%     mask(end-75:end,76:125)=0;
%     mask(end-125:end,end-75:end)=0;
%     mask(end-75:end,end-125:end-75)=0;
end


ZernikeModeN=45; %How many zernike modes used for decomposition


%% read the experimental AO pattern and calculate the zernike coefficients 

% List the AO patterns in the filePath
AOpatternList = dir(fullfile(filePath,"*.png"));


coeZernike_exp=zeros(length(AOpatternList),ZernikeModeN);

for i=1:length(AOpatternList)  
    AOFilePath = fullfile(filePath,AOpatternList(i).name);
    AOPattern=imread(AOFilePath);
    
    [~,coeZernike_exp(i,:),xmatrix] = zernike_decomposition(AOPattern,ZernikeModeN,mask);
end

%% interpolation
coeZernike_interp=zeros(length(dz_interp),ZernikeModeN);

for i=1:ZernikeModeN
    coeZernike_interp(:,i)=interp1(dz,coeZernike_exp(:,i),dz_interp);
end

%% reconstruct
  %zernike polynomial
zernike=xmatrix;
  
savepath = fullfile(filePath, "interp_modal");
mkdir(savepath);

for i=1:length(dz_interp)
    z=dz_interp(i);
    WF_fit = zeros(size(zernike,1));
    for j = 1:ZernikeModeN
        Mode = zernike(:,:,j);                                % Mode: 45x45 wavefront for each Zernike mode
        WF_fit = WF_fit + Mode * coeZernike_interp(i,j);   % Zernike_coef*mode=phase --> Zer_coef=phase/mode
    end
   
    WF_fit = mod(WF_fit,256);
    %--mask
    WF_fit(mask==0)=0;
    %------
    
    WF_fit = uint8(WF_fit);
    %save the interpolated patterns
    imwrite(WF_fit,fullfile(savepath,strcat(num2str(z),'_AO.bmp')));

end   
flag = 1;
end