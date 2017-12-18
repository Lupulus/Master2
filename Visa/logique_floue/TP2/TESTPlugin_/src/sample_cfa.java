import ij.*;
import ij.plugin.filter.*;
import ij.process.*;
import ij.gui.*;

public class sample_cfa implements PlugInFilter {

	ImagePlus imp;	// Fen�tre contenant l'image de r�f�rence
	int width;		// Largeur de la fen�tre
	int height;		// Hauteur de la fen�tre

	public int setup(String arg, ImagePlus imp) {
		this.imp = imp;
		return PlugInFilter.DOES_RGB;
	}


	public void run(ImageProcessor ip) {

		// Lecture des dimensions de la fen�tre
		width = imp.getWidth();
		height = imp.getHeight();


		// Calcul des �chantillons de chaque composante de l'image CFA
		ImageStack samples_stack = imp.createEmptyStack();
		samples_stack.addSlice("rouge", cfa_samples(ip,0));	// Composante R
		samples_stack.addSlice("vert", cfa_samples(ip,1));// Composante G
		samples_stack.addSlice("bleu", cfa_samples(ip,2));	// Composante B

		// Cr�ation de l'image r�sultat
		ImagePlus cfa_samples_imp = imp.createImagePlus();
		cfa_samples_imp.setStack("�chantillons couleur CFA", samples_stack);

		cfa_samples_imp.show();
	}
	
	
	private final static float[] MASQUE_HR_B = {1,2,1, 2,4,2, 1,2,1};
	private final static float[] MASQUE_HG = {0,1,0, 1,4,1, 0,1,0};
	
	ImageProcessor cfa_samples(ImageProcessor cfa_ip, int k) {

		// Image couleur de r�f�rence et ses dimensions
		ImageProcessor ip = imp.getProcessor();
		width = imp.getWidth();
		height = imp.getHeight();

		int pixel_value = 0;	// Valeur du pixel source
		ImageProcessor res = new ByteProcessor(width,height);


		if (k == 1) {
			// �chantillons G
			for (int y=0; y<height; y+=2) {
				for (int x=0; x<width; x+=2) {
					pixel_value = ip.getPixel(x,y);
					int green = (int)(pixel_value & 0x00ff00)>>8;
				res.putPixel(x,y,green);
				}
			}
			for (int y=1; y<height; y+=2) {
				for (int x=1; x<width; x+=2) {
					pixel_value = ip.getPixel(x,y);
					int green = (int)(pixel_value & 0x00ff00)>>8;
				res.putPixel(x,y,green);
				}
			}
		} else if (k == 0) {
			// �chantillons R
			for (int y=0; y<height; y+=2) {
				for (int x=1; x<width; x+=2) {
					pixel_value = ip.getPixel(x,y);
					int red = (int)(pixel_value & 0xff0000)>>16;
				res.putPixel(x,y,red);
				}
			}
		} else if (k == 2) {
			// �chantillons B
			for (int y=1; y<height; y+=2) {
				for (int x=0; x<width; x+=2) {
					pixel_value = ip.getPixel(x,y);
					int blue = (int)(pixel_value & 0x0000ff);
					res.putPixel(x,y,blue);
				}
			}
		}
		
		/*if (k == 1) {
			res.convolve(MASQUE_HG, 3, 3);
		} else {
			res.convolve(MASQUE_HR_B, 3, 3);
		}
		
		run("sample cfa");
setSlice(1);

run("Convolve...", "text1=[1 2 1\n2 4 2\n1 2 1\n] normalize stack");
close();

		*/

		return res;
	}
}