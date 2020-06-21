function [flag] = AO_interpolation_zonal(filePath,dz,dz_interp,N, pixelNum, pixelNum_subregion)
% This code uses zonal approach to interpolate the AO Patterns at multiple
% image planes. The code help you get the interpolated AO patterns between measured patterns.
% Input:
% 1. filePath: the folder path that stores txt files recording phase gradients for each measurement. The files will be read
% from the folder in order. Those txt files can be used to reconstruct the
% AO patterns. The phase gradients are actually gray level (0-255) for the files in the folder 
% 2. dz: how much defocus applied to the system for each measurement.
% 3. dz_interp: The defocus at which you want to get the interpolated
% patterns.
% 4. N: We divided the backpupil into N*N segments and measured the phase
% gradients on those segments for AO reconstruction.
% 5. pixeNum: There're pixeNum*pixeNum pixels on each AO pattern
% 6. pixelNum_subregion: For each segment,there're
% pixelNum_subregion*pixelNum_subregion pixels.
% output: the code will automatically create a folder named "interp_zonal"
% under the filePath. The interpolated AO patterns will be saved in the
% folder.

if nargin == 0
    filePath='.\test';
    dz = -200:50:200;
    dz_interp = -200:10:200;
    N=9;
    PixelNum=512;
    pixelNum_subregion=50;
end


iterationNum=500;



%% read the.txt files in the folder which contains the phase gradients of the segments and store the slope information in phaseXSlope/phaseYSlope

phaseXSlope=zeros(N,N,length(dz));
phaseYSlope=zeros(N,N,length(dz));

txtFileList = dir(fullfile(filePath,"*.txt"));
for i=1:length(txtFileList)
    file=fullfile(filePath,txtFileList(i).name);
    [phaseXSlope(:,:,i),phaseYSlope(:,:,i)]=readPhaseReconstruction(file,N);
end

%% do interpolation on the slope information

phaseXSlope_interp=zeros(N,N,length(dz_interp));
phaseYSlope_interp=zeros(N,N,length(dz_interp));

for i=1:N
    for j=1:N
        phaseXSlope_interp(i,j,:)=interp1(dz,squeeze(phaseXSlope(i,j,:)),dz_interp);
        phaseYSlope_interp(i,j,:)=interp1(dz,squeeze(phaseYSlope(i,j,:)),dz_interp);
    end
end

%% generate the interpolated AO patterns

savepath = fullfile(filePath,"interp_zonal");
mkdir(savepath)

for i=1:length(dz_interp)
    z=dz_interp(i);
    [pattern,~] = AOPattern(phaseXSlope_interp(:,:,i),phaseYSlope_interp(:,:,i),N, iterationNum,pixelNum_subregion);
    %pattern now is in unit of rad.
    
    %expand the pattern
    pattern_expand=expandPattern(pattern,PixelNum);
    
    saveName=strcat(num2str(z),'_AO.bmp');
    imwrite(pattern_expand,fullfile(savepath,saveName));
end

end







