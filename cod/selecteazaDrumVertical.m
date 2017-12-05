function d = selecteazaDrumVertical(E,metodaSelectareDrum)
%selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul vertical ales

d = zeros(size(E,1),2);

switch metodaSelectareDrum
    case 'aleator'
        %pentru linia 1 alegem primul pixel in mod aleator
        linia = 1;
        %coloana o alegem intre 1 si size(E,2)
        coloana = randi(size(E,2));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                optiune = randi(2) - 2; %genereaza -1 sau 0
            else
                optiune = randi(3)-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
    case 'greedy'
        [N, M] = size(E);
        [~, j] = min(E(1, :));
        d(1,:) = [1 j];
        for i = 2:N
            if j == 1
                [~, j] = min([E(i,j),E(i,j+1)]);
            elseif j == M
                [~, j] = min([E(i,j),E(i,j-1)]);
            else
                [~, j] = min([E(i,j-1), E(i,j), E(i,j+1)]);
            end
            d(i,:) = [i j];
        end
        
    case 'programareDinamica'
        [N, M] = size(E);
        matriceDistanta = zeros(N, M);
        for i = 1:N
            for j = 1:M
                if i == 1
                    matriceDistanta(i,j) = E(i,j);
                elseif j == 1
                    matriceDistanta(i,j) = E(i,j) + min(matriceDistanta(i - 1,j), matriceDistanta(i - 1, j + 1));
                elseif j == M
                    matriceDistanta(i,j) = E(i,j) + min(matriceDistanta(i - 1,j), matriceDistanta(i - 1, j - 1));
                else
                    matriceDistanta(i,j) = E(i,j) + min([matriceDistanta(i - 1, j - 1), matriceDistanta(i - 1, j), matriceDistanta(i - 1, j + 1)]);
                end
            end
        end
        
        [~, j] = min(matriceDistanta(N, :));
        
        for i=N:-1:2
            d(i, :) = [i j];
            if j == 1
                if matriceDistanta(i,j) ~= E(i,j) + matriceDistanta(i-1,j)
                    j = j + 1;
                end
            elseif j == M
                if matriceDistanta(i,j) ~= E(i,j) + matriceDistanta(i-1,j)
                    j = j - 1;
                end
            else
                if matriceDistanta(i,j) == E(i,j) + matriceDistanta(i-1,j-1)
                    j = j - 1;
                elseif matriceDistanta(i,j) == E(i,j) + matriceDistanta(i-1,j+1)
                    j = j + 1;
                end
            end
        end
        d(1, :) = [1 j];
    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end