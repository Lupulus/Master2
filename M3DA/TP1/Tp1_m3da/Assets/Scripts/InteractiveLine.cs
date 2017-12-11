using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractiveLine : MonoBehaviour {

    public List<Vector3> position = new List<Vector3>();
    public LineRenderer lr;
	// Use this for initialization
	void Start () {
		lr = this.gameObject.AddComponent<LineRenderer>();
        lr.widthMultiplier = 0.2f;
        // lr.material.color = color;
        SetCircle(1.0f);
    }
	
	// Update is called once per frame
	void Update () {
		lr = this.gameObject.GetComponent<LineRenderer>();

        lr.SetPositions(position.ToArray());
        lr.positionCount = position.Count;
    }


    void SetSegment()
    {
        position.Clear();
        position.Add(new Vector3(-2, 0, 0));
        position.Add(new Vector3(2, 0, 0));
        
    }

    void SetCircle(float r)
    {
        position.Clear();
        float angle = 0.1f;
        for (int i = 0; i <= 31; i++)
        {
            position.Add(new Vector3(r * Mathf.Cos(angle), r * Mathf.Sin(angle), 0));
            angle += 2 * Mathf.PI / 30f;
        }
    }

    public Vector3 TangentLine(int i)
    {
        return (i > 0 && i < position.Count) ? position[i + 1] - position[i - 1] :
            (i == 0 ? position[i + 1] - position[i] : position[i] - position[i - 1]) ;
    }

}
