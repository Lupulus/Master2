using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Extrusion : MonoBehaviour {

    public Mesh mesh;
    public InteractiveLine path;
    public InteractiveLine section;
    public Vector3[] position;

    // Use this for initialization
    void Start () {
        GetComponent<MeshFilter>().mesh = mesh = new Mesh();
        mesh.name = "Extrude";
    }
	
	// Update is called once per frame
	void Update () {
		
	}

    void ExtrudeLine()
    {
        List<Vector3> positionP = path.position, positionS = section.position;
        position = new Vector3[positionP.Count * positionS.Count];
        int index = 0;

        for (int i = 0; i < positionP.Count; i++)
        {
            Quaternion q = Quaternion.FromToRotation(Vector3.up, path.TangentLine(i));
            for (int j = 0; j < positionS.Count; j++)
            {
                Vector3 nSectionPos = q * new Vector3(positionS[j].x, 0, positionS[j].y);
                Vector3 pos = nSectionPos + positionP[i];
                position[index] = pos;
                index++;
            }
        }
        createTriangle();
    }


    void createTriangle()
    {
        List<int> triangles = new List<int>();
        int sectionSize = section.position.Count;
        int pathSize = path.position.Count;
        int[] triangle = new int[sectionSize * pathSize];


        for (int j = 0; j < pathSize - 1; j++)
        {
            for (int i = 0; i < sectionSize - 1; i++)
            {
                int bottomLeft = i + j * sectionSize;
                int bottomRight = (i + 1) + j * sectionSize;
                int topLeft = bottomLeft + sectionSize;
                int topRight = bottomRight + sectionSize;

                triangles.Add(topLeft);
                triangles.Add(bottomLeft);
                triangles.Add(bottomRight);

                triangles.Add(topLeft);
                triangles.Add(bottomRight);
                triangles.Add(bottomLeft);

                triangles.Add(bottomRight);
                triangles.Add(topRight);
                triangles.Add(topLeft);

                triangles.Add(bottomRight);
                triangles.Add(topLeft);
                triangles.Add(topRight);
            }
        }

        mesh.Clear();
        mesh.vertices = position;
        mesh.triangles = triangles.ToArray();
    }

    void OnDrawGizmos()
    {
        if (position == null)
            return;
        Gizmos.color = Color.red;
        for (int i = 0; i < position.Length; ++i)
        {
            Gizmos.DrawSphere(transform.TransformPoint(position[i]), 0.02f);
        }
    }
}
