macro "acp"{

//on récupère l'image de test
open();
title = getTitle();
//séparation de l'image en rouge, vert et bleu puis on les stack
run("Split Channels");
selectWindow(title + " (blue)");
selectWindow(title + " (green)");
selectWindow(title + " (red)");
run("Images to Stack", "name=RGB1 title=[] use");
//une fois stacké, on lance PCA dessus puis on passe la stack obtenue en 8 bit et enfin on repasse en RGB
run("PCA ");
selectWindow("PCA of RGB1");
run("8-bit");
run("Stack to RGB");

W = getWidth();
H = getHeight();
clusters = newArray(0,0,0) ;
n_clusters = 0;

for (j = 0; j < H; j++) {
	for (i = 0; i < W; i++) {
		p = getPixel(i, j);
		isCluster = false;

		for(k = 0; k < 3; k++){
			if(clusters[k] == p)
				isCluster = true;
		}

		if(n_clusters < 3 && !isCluster){
			clusters[n_clusters] = p;
			n_clusters ++;
		}
	}
}


//à ce stade, on a appris sur l'image de base et on connait donc les clusters
//on demande l'image de test
open();

segmenter = getImageID();
title = getTitle();
selectWindow(title);
run("Split Channels");
selectWindow(title + " (blue)");
selectWindow(title + " (green)");
selectWindow(title + " (red)");
run("Images to Stack", "name=RGB2 title=[] use");
run("PCA ");
selectWindow("PCA of RGB2");
run("8-bit");
run("Stack to RGB");

}
