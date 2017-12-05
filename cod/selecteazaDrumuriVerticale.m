function matriceDrumuri = selecteazaDrumuriVerticale(img,E,metodaSelectareDrum,numarPixeliLatime,ploteazaDrum,culoareDrum)

matriceDrumuri = zeros(size(E));
[N, ~] = size(E);

for k = 1:numarPixeliLatime
    E = calculeazaEnergie(img);
    drum = selecteazaDrumVertical(E,metodaSelectareDrum);
    img = eliminaDrumVertical(img,drum);
    for i = 1:N
        j = 1;
        while drum(i,2) > 1 || matriceDrumuri(i, j) == 1
            if matriceDrumuri(i, j) == 0
                drum(i, 2) = drum(i, 2) - 1;
            end
            j = j + 1;
        end
        matriceDrumuri(i, j) = 1;
    end
    
end