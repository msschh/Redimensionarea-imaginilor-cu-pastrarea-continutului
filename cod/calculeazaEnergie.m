function E = calculeazaEnergie(img)
%calculeaza energia la fiecare pixel pe baza gradientului
%input: img - imaginea initiala
%output: E - energia

%urmati urmatorii pasi:
%transformati imaginea in grayscale
%folositi un filtru sobel pentru a calcula gradientul in directia x si y
%calculati magnitudiena gradientului
%E - energia = gradientul imaginii

%completati aici codul vostru
imgGray = rgb2gray(img);
%[E, ~] = imgradient(imgGray);
filter = fspecial('sobel');
imgRez1 = imfilter(double(imgGray), filter);
filter = imrotate(filter,90);
imgRez2 = imfilter(double(imgGray), filter);
E = sqrt(imgRez1.^2 + imgRez2.^2);