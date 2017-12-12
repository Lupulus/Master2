macro "kmeans-discri_lineaire" {


open("images_2016/cas_3_dalton15.bmp");

run("k-means Clustering ...", "number_of_clusters=4 cluster_center_tolerance=0.00010000 enable_randomization_seed randomization_seed=48 show_clusters_as_centroid_value");

image_cluster = getImageID();
W = getWidth();
H = getHeight();
selectImage(image_cluster);

for(i=0; i<3; i++){
	
}

for (j=0; j<H; j++) {
	for (i=0; i<W; i++) {
		
	}
}

//run("Color Space Converter", "from=RGB to=HSB white=D65");













}
