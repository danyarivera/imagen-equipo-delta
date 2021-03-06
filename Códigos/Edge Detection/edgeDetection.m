f=imread('radiograph1.jpg'); %Lee una imagen especifica de la computadora y la pasa a figure en matlab
f=imresize(f,0.25); %El imresize cambia el tama?o de la imagen, en este caso escalandola a 0.25
f=double(f(:,:,1)); %
imshow(f,[]) % Muestra la imagen en una escala de grises y se especifica el rango de visualizacion

%%
edgex=[1,-1] %Crea un arreglo del borde x
g1=conv2(f,edgex,'same'); %Devuelve una seccion de la convolucion, en este caso el centro. (Borde X)
imshow(g1,[-10,10]); % Muestra una imagen en escala de grises con rango de visualizacion de -10 a 10 de la conv2.
%%
edgey=[-1 -2 -1;0,0,0;1,2,1]/8 % Crea un areglo del borde y
g2=conv2(f,edgey,'same'); % Devuelve una seccion de la convolucion, en este caso del centro (Borde y)
imshow(g2,[-10,10])  % Muestra una imagen en escala de grises con rango de visualizacion de -10 a 10 de la convolucion central.
figure(2)
subplot(1,2,1)
imshow(g1,[-10,10])  % Muestra una imagen en escala de grises con rango de visualizacion de -10 a 10 de la convolucion central.
subplot(1,2,2)
imshow(g2,[-10,10])  % Muestra una imagen en escala de grises con rango de visualizacion de -10 a 10 de la convolucion central.

edgex=[1,-1]
g1=conv2(f,edgex,'same');
imshow(g1,[-10,10]);
%% 
edgey=[-1 -2 -1;0,0,0;1,2,1]/8 % Crea un arreglo del borde Y
g2=conv2(f,edgey,'same'); % Devuelve una seccion de la convolucion, en este caso el centro. (Borde Y)
imshow(g2,[-10,10]) % Muestra una imagen en escala de grises con rango de visualizacion de -10 a 10 de la convolucion central.
figure(2) % Inicializa otra figura para que no se borre la anterior
subplot(1,2,1) % Divide la figure(2) en cuadriculas (subgraficas)
imshow(g1,[-10,10]) % Muestra una imagen en escala de grises con rango de visualizacion de -10 a 10 de la convolucion central.
subplot(1,2,2) % Divide la figure(2) en cuadraculas (subgraficas)
imshow(g2,[-10,10]) % Muestra una imagen en escala de grises con rango de visualizacion de -10 a 10 de la convolucion central.
%%
figure(3)
subplot(1,1,1)
%%
edgex=[1,0,-1;2,0,-2;1,0,-1]/8  % Crea un areglo del borde x 
gx=conv2(f,edgex,'same'); %Devuelve una seccion de la convolucion, en este caso del centro (Borde x)
gy=conv2(f,edgey,'same');%Devuelve una seccion de la convolucion, en este caso del centro (Borde y)
mag=abs(gx)+abs(gy); %Suma de los absolutos para obtener su magnitud
imshow(mag,[]); %Muestra la imagen en escala de grises
%%
noisemask = [-1, 0 1] % Crea un arreglo para reducir el ruido de la imagen 
noiseimage = conv2(f,noisemask,'same'); % Devuelve la parte central de la convolucion, la misma medida que f.
noisevariance = mean2(noiseimage.^2); % Calcula la varianza mediante la media de la convolución.
noisestd = sqrt(noisevariance/2); % Calcula la derivacion estandar sacando la raiz cuadrada
edgedetection1 = mag > noisestd; % Selecciona los bordes fuertes, pero no asegura continuidad
edgedetection2 = mag > 2*noisestd; % Selecciona los bordes fuertes, pero no asegura continuidad
subplot(1,2,1) % Subimagenes
imshow(edgedetection1,[]); % Muestra imagen en escala de grises
subplot(1,2,2) % Subimagenes
imshow(edgedetection2,[]); % Muestra imagen en escala de grises
figure(4) %Nueva figura
subplot(1,1,1) % Subimagenes
angle=atan2(gy,gx); % Devuelve la tangente inversa de ls convoluciones
imshow(angle,[]); % Muestra imagen en escala de grises
%%
edgcany=edge(f,'Canny'); % Detecta los bordes mediante metodo de Prewitt(Canny)
imshow(edgcany,[]); %Muestra una imagen en escala de grises 
