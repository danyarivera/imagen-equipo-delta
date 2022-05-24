%% Equipo 3
%% Integrantes: 
%% Fecha 24/05/2022

f=imread('radiograph2.jpg');
f=double(f(:,:,1));
f=f/max(max(f));
f=imresize(f,0.25);
figure(1)
imshow(f,[]);
%% Thresholding
%Muesra la segentación de la imagen en valores mayores a 0.5, 0,75 y 0.80
%respectivamente en base a los valores en la escala de grises

seg1 = f > 0.5;
figure()
imshow(seg1,[])
figure()
imshow(seg1.*f,[])
seg1 = f < 0.75;
figure()
imshow(seg1,[])
figure()
imshow(seg1.*f,[])

figure()
imhist(f) %Muestra un histograma en relación a una escala de grises 

% Use a third threshold based on the histogram
% Se seleccionaron los valores menores a 0.1 para la segmentación 
% ya que es donde se ven valores más altos en el histograma.
seg1 = f < 0.1; % 
figure()
imshow(seg1,[])
figure()
imshow(seg1.*f,[])
%% 
%% Otsu method
%calcula un umbral total de la imagen en escala de grises mediante el
%método OTSU 

thr = graythresh(f);
seg1 = f > thr;
figure()
imshow(seg1,[])
dxp=[0,1;-1,0];
dyp=[1,0;0,-1];
edgemap = abs(conv2(seg1,dxp,'same'))+abs(conv2(seg1,dyp,'same'));
figure()
imshow(f+edgemap,[0,1]);

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
figure()
imshow(B)
title("Labeled Image")
imshow(int8(255*f)<Centers(1),[])
imshow(int8(255*f)<Centers(2),[])
imshow(int8(255*f)>Centers(3),[])
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
imshow(f+edgemap,[0,1]);

% Do the same procedure but now with 5 centers.
[L,Centers] = imsegkmeans(int8(255*f),5);
B = labeloverlay(f,L);
figure()
imshow(B)
title("Labeled Image")
imshow(int8(255*f)<Centers(1),[])
imshow(int8(255*f)<Centers(2),[])
imshow(int8(255*f)>Centers(3),[])
imshow(int8(255*f)>Centers(4),[])
imshow(int8(255*f)>Centers(5),[])
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
imshow(f+edgemap,[0,1]);

% Is the segmentation better?
%En este caso la segmentación de 3 centros es mejor, segmenta materia 
% blanca,gris y el fondo,en cambio la de 5 centros segmenta más partes de 
% la imagen haciendo más dificil diferenciar lo que se está segmentando
% a simple vista.


%% Watershed segmentation

edgeC = edge(f,'Canny');
imshow(edgeC,[])
D = bwdist(edgeC);
imshow(D,[])
title('Distance Transform of Binary Image')
L = watershed(D);

edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
imshow(f+edgemap,[0,1]);


L(edgeC) = 0;
%% 
% Display the resulting label matrix as an RGB image.

rgb = label2rgb(L,'jet',[.5 .5 .5]);
imshow(rgb)
title('Watershed Transform')

% provide an alterante segmentation based on a different edge detector
%% SOBEL METHOD
edgeC = edge(f,'sobel');
