macro "acp"{
Dialog.create("RGB/HSB?");
Dialog.addChoice("Espace couleur:", newArray("RGB", "HSB"));

if (Dialog.getChoice() != "RGB") {
	run("Color Space Converter", "from=RGB to=HSB white=D65");
}

setBatchMode(true);

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
run("Stack to RGB1");
selectWindow("Stack to RGB1");
run("k-means Clustering ...", "number_of_clusters=4 cluster_center_tolerance=0.00010000 enable_randomization_seed randomization_seed=48 show_clusters_as_centroid_value");


//K-means
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
run("Stack to RGB2");

for(j = 0; j < H; j++){
	for(i = 0; i < W; i++){
		p = getPixel(i,j);
		min = 1000000000;
		Rp = (p & 0xff0000) >> 16;
		Gp = (p & 0x00ff00) >> 8;
		Bp = (p & 0x0000ff) ;
		for(k = 0; k < 4; k++){
			Rk = (clusters[k] & 0xff0000) >> 16;
			Gk = (clusters[k] & 0x00ff00) >> 8;
			Bk = (clusters[k] & 0x0000ff) ;
			Rs = pow(Rp - Rk, 2);
			Gs = pow(Gp - Gk, 2);
			Bs = pow(Bp - Bk, 2);
			if( (((Rs & 0xff ) << 16) + ((Gs & 0xff) << 8) + Bs & 0xff) < min){
				Rn = Rk;
				Gn = Gk;
				Bn = Bk;
				min = ((Rs & 0xff ) << 16) + ((Gs & 0xff) << 8) + Bs & 0xff;
			}
		}
		nouvelle_couleur = ((Rn & 0xff ) << 16) + ((Gn & 0xff) << 8) + Bn & 0xff;
		setPixel(i, j, nouvelle_couleur);
	}
}

setBatchMode(false);
}
