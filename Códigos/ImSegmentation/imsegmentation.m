%% Equipo 3
%% Integrantes: Mariely Charles
%%              Ariana Fragoso
%%              Danya Rivera
%%              Sebastián Mencías
%% Fecha 24/05/2022

f=imread('radiograph2.jpg');
f=double(f(:,:,1));
f=f/max(max(f));
f=imresize(f,0.25);
figure(1)
imshow(f,[]);
title('Original')
%% Thresholding
% Muesra la segmentación de la imagen en valores mayores a 0.5, 0,75 y 
% menores a 0.80 respectivamente en base a los valores en la escala de
% grises porsteriormente para multiplicar el resultado por la imagen
% original.
seg1 = f > 0.5;

%imshow(seg1,[]);
figure(2)
subplot(2,2,1)
imshow(seg1.*f,[])
title('Threshold>0.5')
hold on
seg2 = f < 0.75;

%imshow(seg2,[]);
subplot(2,2,2)
imshow(seg2.*f,[])
title('Threshold <0.75')
hold on

% Use a third threshold based on the histogram

% Se seleccionaron los valores menores a 0.1 para la segmentación 
% ya que es donde se ven valores más altos en el histograma, en la escala 
% de grises estos valores se encuentran en la parte más oscura (negro)
seg3 = f < 0.1; % 

%imshow(seg3,[]);
subplot(2,2,3)
imshow(seg3.*f,[])
title('Threshold <0.1')

%Muestra un histograma en relación a una escala de grises 
hold on
subplot(2,2,4)
imhist(f) 
title('Histograma')

%% Otsu method
% Calcula un umbral total de la imagen en escala de grises mediante el
% método OTSU 

thr = graythresh(f);
seg1 = f > thr;
figure(3)
subplot(1,2,1)
imshow(seg1,[])
title('Threshold')
dxp=[0,1;-1,0];
dyp=[1,0;0,-1];
edgemap = abs(conv2(seg1,dxp,'same'))+abs(conv2(seg1,dyp,'same'));
subplot(1,2,2)
imshow(f+edgemap,[0,1]);
title('Otsu Method')
hold on

% Compare the otsu provided threshold vs the one you selected in the
% preview step.
% Do you trust the Otsu treshold?
% Si, en el caso de threshold basado en un histograma no es tan preciso si
% no se ponen los límites de la escala de grises correctos, en cambio en
% método OTSU ya elige un umbral que minimiza la varianza en esta escala de
% grises haciendo una segmentación más limpia y con mejor visibilidad.
%% Kmeans segmentation

[L,Centers] = imsegkmeans(int8(255*f),3); %Vuelve los valores a enteros y 
% se señala la cantidad de centros, en este caso 3
B = labeloverlay(f,L);

%figure(4)
% subplot(1,2,1)
%imshow(B)

% title("Labeled Image")
imshow(int8(255*f)<Centers(1),[]);
imshow(int8(255*f)<Centers(2),[]);
imshow(int8(255*f)>Centers(3),[]);
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
figure(4)
subplot(1,2,1)
imshow(f+edgemap,[0,1])
title('Kmeans Segmentation 3')
hold on

% Do the same procedure but now with 5 centers.
[L,Centers] = imsegkmeans(int8(255*f),5);
%B = labeloverlay(f,L);
% subplot(1,2,1)
% imshow(B)
% title("Labeled Image")
imshow(int8(255*f)<Centers(1),[]);
imshow(int8(255*f)<Centers(2),[]);
imshow(int8(255*f)>Centers(3),[]);
imshow(int8(255*f)>Centers(4),[]);
imshow(int8(255*f)>Centers(5),[]);
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
hold on
figure(4)
subplot(1,2,2)
imshow(f+edgemap,[0,1]);
title('Kmeans Segmentation 5')

% Is the segmentation better?
% En este caso la segmentación de 3 centros es mejor, segmenta materia 
% blanca,gris y el fondo,en cambio la de 5 centros segmenta más partes de 
% la imagen haciendo más difícil diferenciar lo que se está segmentando
% a simple vista.


%% Watershed segmentation Canny

edgeC = edge(f,'Canny');
D = bwdist(edgeC);
figure(5)
imshow(D,[]);
title('Distance Transform of Binary Image (Canny)')
hold on
L = watershed(D);
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
imshow(f+edgemap,[0,1]);
L(edgeC) = 0;
%% 
% Display the resulting label matrix as an RGB image.

rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure(6)
imshow(rgb)
title('Watershed Transform Canny')

% provide an alterante segmentation based on a different edge detector

%% Watershed segmentation Sobel

edgeC = edge(f,'Sobel');
D = bwdist(edgeC);
figure(7)
imshow(D,[]);
title('Distance Transform of Binary Image (Sobel)')
hold on
L = watershed(D);
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
imshow(f+edgemap,[0,1]);
L(edgeC) = 0;

%% 
% Display the resulting label matrix as an RGB image.

rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure(8)
imshow(rgb)
title('Watershed Transform Sobel')

%% SOBEL METHOD & CANNY METHOD edge detector

edgeC = edge(f,'sobel');
figure(9)
subplot(1,2,1)
imshow(edgeC,[])
title('Sobel Method')
hold on
edgeC = edge(f,'Canny');
subplot(1,2,2)
imshow(edgeC,[])
title('Canny Method')
