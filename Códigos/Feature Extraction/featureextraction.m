%%Create Gray-Level Co-occurrence Matrix for Grayscale Image %
I0 = imread('dog.jpeg');
I = rgb2gray(I0);
imshow(I)
glcm = graycomatrix(I,'Offset',[2 0])

%Create Gray-Level Co-occurrence Matrix Returning Scaled Image
I = [ 1 1 5 6 8 8; 2 3 5 7 0 2; 0 2 3 5 6 7]
[glcm,SI] = graycomatrix(I,'NumLevels',9,'GrayLimits',[])

%Calculate GLCMs using Four Different Offsets
I0 = imread('dog.jpeg');
I = rgb2gray(I0);
imshow(I)
offsets = [0 1; -1 1;-1 0;-1 -1];
[glcms,SI] = graycomatrix(I,'Offset',offsets);
imshow(rescale(SI))
whos

%Calculate Symmetric GLCM for Grayscale Image
I0 = imread('dog.jpeg');
I = rgb2gray(I0);
imshow(I)
[glcm,SI] = graycomatrix(I,'Offset',[2 0],'Symmetric',true);
glcm
imshow(rescale(SI))

%extractLBPFeatures
gato = imread('gato.jpg');
gatobw = rgb2gray(gato)
rotatedcat = imread('rotatedcat.jpg');
rotatedcatbw = rgb2gray(rotatedcat)
chess = imread('chess.png');
chessbw = rgb2gray(chess)
figure
imshow(gatobw)
title('cat')
figure
imshow(rotatedcatbw)
title('Rotated cat')
figure
imshow(chessbw)
title('Chess')
lbpBricks1 = extractLBPFeatures(gatobw,'Upright',false);
lbpBricks2 = extractLBPFeatures(rotatedcatbw,'Upright',false);
lbpCarpet = extractLBPFeatures(chessbw,'Upright',false);
brickVsBrick = (lbpBricks1 - lbpBricks2).^2;
brickVsCarpet = (lbpBricks1 - lbpCarpet).^2;
figure
bar([brickVsBrick; brickVsCarpet]','grouped')
title('Squared Error of LBP Histograms')
xlabel('LBP Histogram Bins')
legend('cat vs Rotated cat','cat vs Chess')
I = imread('gato.jpg');
I = im2gray(I);
lbpFeatures = extractLBPFeatures(I,'CellSize',[32 32],'Normalization','None');
numNeighbors = 8;
numBins = numNeighbors*(numNeighbors-1)+3;
lbpCellHists = reshape(lbpFeatures,numBins,[]);
lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
lbpFeatures = reshape(lbpCellHists,1,[]);
