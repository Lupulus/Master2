using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Curve : MonoBehaviour {


	public List<Vector3> position; // control points position 
	public List<float> weight;     // control points weight
	Basis basis; // basis functions

	// Use this for initialization
	void Start () {
		position = new List<Vector3> ();
		weight = new List<float> ();
		basis = GameObject.Find ("BasisU").GetComponent<Basis> ();
        //SetSegment ();
        SetCircle();
		basis.SetFromControlCount (position.Count);
	}

	public bool IsSamplePoint() {
		return (basis.currentT >= StartInterval () && basis.currentT <= EndInterval ());
	}

	public Vector3 SamplePoint() {
		return PointCurve (basis.currentT);
	}

	double StartInterval() {
		double res = 0.0;
        res = basis.knot[basis.degree];
        // TODO : start value of the definition of the curve

        return res;
	}

	double EndInterval() {
		double res = -1.0; // hack to avoid a green dot if TODO are not done.
        res = basis.knot[basis.knot.Count - basis.degree];
        // TODO : end value of the definition of the curve

        return res;
	}

	public void Clear() {
		position.Clear ();
		weight.Clear ();
	}

	public void Add(Vector3 p, float poids) {
		position.Add (p);
		weight.Add (poids);
		basis.SetFromControlCount (position.Count);
	}


	public void SetSegment() {
		Clear ();
		Add (new Vector3 (-0.7f, -0.8f, 0), 1.0f);
		Add (new Vector3 (0, 0.8f, 0), 1.0f);
		Add (new Vector3 (0.6f, 0.5f, 0), 1.0f);
	}

	public void SetCircle()
	{
		Clear();
		Add(new Vector3(0.0f, -0.5f, 0.0f), 1.0f); // p0
		Add(new Vector3(-0.5f, -0.5f, 0.0f), Mathf.Cos(1.0472f)); // p1
		Add(new Vector3(-0.25f, 0.0f, 0.0f), 1.0f); // p2
		Add(new Vector3(0.0f, 0.5f, 0.0f), Mathf.Cos(1.0472f)); // p3
		Add(new Vector3(0.25f, 0.0f, 0.0f), 1.0f); // p4
		Add(new Vector3(0.5f, -0.5f, 0.0f), Mathf.Cos(1.0472f)); // p5
		Add(new Vector3(0.0f, -0.5f, 0.0f), 1.0f); // p6

		basis.degree = 2;
	  }

	Vector3 PointCurve(double u) {
		Vector4 result = Vector4.zero;
        for (int k = 0; k < position.Count; k++)
        {
            Vector3 p = position[k] * weight[k];
            float fBase = (float)basis.EvalNkp(k, basis.degree, u);
            result += new Vector4(p.x, p.y, p.z, weight[k]) * fBase;
        }

        // TODO : compute the point of the curve at u

        return new Vector3(result.x, result.y, result.z) / result.w; // * 1.0f / (float)w;
	}

	public List<Vector3> DrawNurbs() {
		List<Vector3> l=new List<Vector3>();
        	int nbPoints = basis.nbPoint;

        	for (double t = StartInterval(); t <=  EndInterval(); t += 1.0/(nbPoints-1))
        	{
            	l.Add(PointCurve(t));
        	}
        	// TODO : set the values of the points of l 
	
        	return l;
	}

	// Update is called once per frame
	void Update () {
	}
}
