function [ m ] = vk_tsnrFromFMR2(fmrfilename)
% function [ m ] = vk_tsnrFromFMR( fmrfilename )
% return tSNR map for FMR fmrfilename
% 1: using a bounding box

x = xff(fmrfilename);

m = double(x.Slice.STCData);

%added by kj
% jj < 120
% jj < 20 || jj > 70
% jj < 70 || jj > 120
% for ii = 1:size(m,1)
%     for jj = 1:size(m,2)
%         for kk = 1:size(m,4)
%             if subi < 3
%                 if ii < 30 || ii > 150 || jj < 70 || jj > 120 || mean(m(ii,jj,:,kk))<=300
%                     m(ii,jj,:,kk) = 0;
%                 end
%             else
%                 if ii < 30 || ii > 150 || jj < 70 || jj > 120 || mean(m(ii,jj,:,kk))<=1500
%                     m(ii,jj,:,kk) = 0;
%                 end
%             end
%             
%         end
%     end
% end

m = mean(m,3) ./ std(m,[],3);

map = xff('map');

map.DimY = size(m,1);
map.DimX = size(m,2);
map.LowerThreshold = 10;
map.UpperThreshold = 30;
map.NrOfSlices = size(m,4);
map.type = 0;
map.ClusterSize = 0;
map.CombinedTypeSlices = map.NrOfSlices;

for i=1:size(m,4)
    map.Map(i).Number = i;
    map.Map(i).Data = single(squeeze(m(:,:,1,i)));   
end

map.saveAs([fmrfilename(1:end-4) '_tsnr_mid.map']);
end

