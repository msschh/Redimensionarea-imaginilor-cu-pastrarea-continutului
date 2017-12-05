function imgRez = maresteInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)

img = imrotate(img,90);
imgRez = uint8(zeros(size(img,1),size(img,2)+numarPixeliInaltime,size(img,3)));
E = calculeazaEnergie(img);
drumuri = selecteazaDrumuriVerticale(img,E,metodaSelectareDrum,numarPixeliInaltime,ploteazaDrum,culoareDrum);
for i = 1:size(img,1)
   k = 1;
   j = 1;
   while k + j - 1 <= size(img,2)+numarPixeliInaltime
       while drumuri(i, j) ~= 0
           if k + j - 1 == 1
               imgRez(i, k + j - 1, :) = img(i, j, :);
               imgRez(i, k + j, 1) = imgRez(i, k + j - 1, 1)/2 + img(i, j + 1, 1)/2;
               imgRez(i, k + j, 2) = imgRez(i, k + j - 1, 2)/2 + img(i, j + 1, 2)/2;
               imgRez(i, k + j, 3) = imgRez(i, k + j - 1, 3)/2 + img(i, j + 1, 3)/2;
           elseif k + j - 1 == size(img,2)+numarPixeliInaltime
               imgRez(i, k + j - 1, 1) = imgRez(i, k + j - 2, 1)/2 + img(i, j, 1)/2;
               imgRez(i, k + j - 1, 2) = imgRez(i, k + j - 2, 2)/2 + img(i, j, 2)/2;
               imgRez(i, k + j - 1, 3) = imgRez(i, k + j - 2, 3)/2 + img(i, j, 3)/2;
               imgRez(i, k + j, :) = img(i, j, :);
           else
               imgRez(i, k + j - 1, 1) = imgRez(i, k + j - 2, 1)/2 + img(i, j, 1)/2;
               imgRez(i, k + j - 1, 2) = imgRez(i, k + j - 2, 2)/2 + img(i, j, 2)/2;
               imgRez(i, k + j - 1, 3) = imgRez(i, k + j - 2, 3)/2 + img(i, j, 3)/2;
               imgRez(i, k + j, 1) = imgRez(i, k + j - 1, 1)/2 + img(i, j, 1)/2;
               imgRez(i, k + j, 2) = imgRez(i, k + j - 1, 2)/2 + img(i, j, 2)/2;
               imgRez(i, k + j, 3) = imgRez(i, k + j - 1, 3)/2 + img(i, j, 3)/2;
           end
           k = k + 1;
           drumuri(i,j) = drumuri(i,j) - 1;
       end
       if j <= size(img,2)
           imgRez(i, k + j - 1, :) = img(i, j, :);
           j = j + 1;
       end    
   end
   
end
imgRez = imrotate(imgRez,270);