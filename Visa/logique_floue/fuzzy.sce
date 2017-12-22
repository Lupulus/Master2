//création des 3 ensembles (tableaux)
//toutes les valeurs sont à 0
basse=zeros(1,40);
moyenne=zeros(1,40);
haute=zeros(1,40);
    
//instanciation de l'ensemble basse 
//on met à 1 de 1 à 10 puis on descend jusque 0 en 20
for i=1:10
    basse(i)=1;
end
for i=11:20
    basse(i)=1-(i-10)*0.1;
end

//instanciation de l'ensemble moyenne 
//on monte jusque 1 de 11 à 20 puis on descend jusque 0 de 21 à 30
for i=11:20
    moyenne(i)=(i-10)*0.1;
end
for i=21:30
    moyenne(i)=1-(i-20)*0.1;
end

//instanciation de l'ensemble basse 
//on monte jusque 1 de 21 à 30 puis met à 1 
for i=21:30
    haute(i)=(i-20)*0.1;
end
for i=31:40
    haute(i)=1;
end

function generation()
    clf();
    plot2d(basse, style = 2);
    plot2d(moyenne, style = 3);
    plot2d(haute, style = 5);
endfunction

function value16()
    //Affichage des résultats pour une température à 16
    disp("Température = 16°")
    disp("Appartenance basse");
    disp(basse(16));
    disp("Appartenance Moyenne");
    disp(moyenne(16));
    disp("Appartenance Haute");
    disp(haute(16));
endfunction

function operatorMinimum()
    clf();
    minim=zeros(1,40);
    for i=1:length(basse)
        minim(i)=min(basse(i), moyenne(i));
        minim(i)=min(minim(i), haute(i));
    end

    plot2d(minim, style = 2);
endfunction

function operatorMaximum()
    clf();
    maxim=zeros(1,40);
    for i=1:length(basse)
        maxim(i)=max(basse(i), moyenne(i));
        maxim(i)=max(maxim(i), haute(i));
    end
    
    plot2d(maxim, style = 2);
endfunction

//generation();
//value16();
//operatorMinimum();
operatorMaximum();
