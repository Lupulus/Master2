using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Basis: MonoBehaviour {


	public List<double> knot; // 
	public int degree=2;      //
    public int nbPoint = 30;
	public double currentT =0; // to get a sample point (represented by the blue vertical bar).
    private int toNb, toCall = 0;
    public Curve curve;

	// Use this for initialization
	void Start () {
		degree = 1;
        toNb = 6;
		//SetUniform (6); // TODO : replace with SetOpenUniform, SetBezier, ...
	}


	public void SetUniform(int nb) {
		knot.Clear();

        double t = (nb - 1);
        for (int i = 0; i < nb; i++)
        {
            knot.Add(i / t);
        }
        // TODO : set knot uniform
    }

    public void SetOpenUniform(int nb)
    {
        knot.Clear();

        

        nb -= degree * 2;

        if (nb < 0) return;

        for (int i = 0; i < degree; i++)
            knot.Add(0);

        double value = 1.0 / (nb - 1);
        for (int i = 0; i < nb; i++)
            knot.Add(i * value);

        for (int i = 0; i < degree; i++)
            knot.Add(1);

    }

    public void SetBezier(int nb)
    {
        knot.Clear();
        degree = curve.position.Count - 1;
        int middle = nb / 2;
        for (int i = 0; i < nb; i++)
        {
            if (i < middle)
                knot.Add(0);
            else
                knot.Add(1);
        }
    }



    public List<Vector3> DrawBasis(int k) {
		nbPoint = 30;
        float d = 1.0f/(nbPoint - 1);
		List<Vector3> res=new List<Vector3>();
        for (float i = 0.0f; i < 1.0f; i+= d)
        {

            res.Add(new Vector3(i, (float)EvalNkp(k, degree, i), 0.0f));
        }

        // TODO : compute points of the curve in l to build the drawn curve.

        return res;		
	}




    public double EvalNkp(int k, int p, double t)
    {
        double res = 0.0;

        if (p == 0)
        {
            if (t >= knot[k] && t < knot[k + 1])
                res = 1.0;
            return res;
        }

        //calcul du dénominateur pour tester sa valeur à 0 afin de respecter la convention (numérateur/0 = 0)
        double convention = knot[k + p] - knot[k];
        if (convention != 0)
        {
            res += (t - knot[k]) / convention * EvalNkp(k, p - 1, t);
        }

        //calcul du dénominateur pour tester sa valeur à 0 afin de respecter la convention (numérateur/0 = 0)
        convention = knot[k + p + 1] - knot[k + 1];
        if (convention != 0)
        {
            res += (knot[p + k + 1] - t) / convention * EvalNkp(k + 1, p - 1, t);
        }


        return res;

    }

    public void SetFromControlCount(int nb) {
		if (degree + nb + 1 != knot.Count) {
			SetUniform (degree + nb + 1);
		}
	}

	// Update is called once per frame
	void Update () {

        if (Input.GetKey(KeyCode.A))
            toCall = 0;

        if (Input.GetKey(KeyCode.Z))
            toCall = 1;

        if (Input.GetKey(KeyCode.E))
            toCall = 2;

        switch (toCall)
        {
            case 0: SetUniform(toNb);
                break;
            case 1: SetOpenUniform(toNb);
                break;
            case 2: SetBezier(toNb);
                break;
            default:
                break;
        }
	}

}
