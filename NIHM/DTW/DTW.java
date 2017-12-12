import java.util.ArrayList;
import java.util.List;

import javafx.geometry.Point2D;

public class DTW {
	 

	public static List<Point2D> preCompute(List<Point2D> seq) {
		
		double pymax = seq.stream().map(Point2D::getY).max(Double::compareTo).get();
		double pxmax = seq.stream().map(Point2D::getX).max(Double::compareTo).get();
		double pymin = seq.stream().map(Point2D::getY).min(Double::compareTo).get();
		double pxmin = seq.stream().map(Point2D::getX).min(Double::compareTo).get();

		double ex = 100 / (pxmax - pxmin);
		double ey = 100 / (pymax - pymin);
		
		double tx = -pxmin;
		double ty = -pymin;
		
		List<Point2D> r = new ArrayList<>(seq.size());
		
		for (int i = 0; i < seq.size(); i++) {
			Point2D p = new Point2D(seq.get(i).getX() * ex  + tx, seq.get(i).getY() * ey + ty);
			r.add(p);
		}
		
		return null;
	}
	

	public static Matrix alignment(List<Point2D> seq1, List<Point2D> seq2) {
		Matrix r = new Matrix(seq1.size(), seq2.size());
		
		double[][] dtw = r.items;
		Couple[][] cpl = r.couple;
		
		// Init colonne 
		for (int i = 1; i < seq1.size(); i++) {
			dtw[i][0] = dtw[i - 1][0] + seq1.get(i).distance(seq2.get(0)); 
		}
		
		// Init line
		for (int j = 1; j < seq2.size(); j++) {
			dtw[0][j] = dtw[0][j - 1] + seq1.get(0).distance(seq2.get(j)); 
		}
		
		
		for (int i = 1; i < seq1.size(); i++) {
			for (int j = 1; j < seq2.size(); j++) {
				double min = dtw[i-1][j];
				Couple couple = new Couple(i-1, j);

				if (min > dtw[i][j-1]) {
					min = dtw[i][j-1];
					couple = new Couple(i, j-1);
				} else if (min > dtw[i-1][j-1]) {
					min = dtw[i-1][j-1];
					couple = new Couple(i-1, j-1);
				}
				
				dtw[i][j] = seq1.get(0).distance(seq2.get(j)) + min; 
				cpl[i][j] = couple;
			}
		}
		
		return r;
	}
		
}
