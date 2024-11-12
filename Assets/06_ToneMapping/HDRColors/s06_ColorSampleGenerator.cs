using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class s06_ColorSampleGenerator : MonoBehaviour
{
  public GameObject spherePrefab;
  public Texture texture;
  private float[] intensitys;
  private Color[] colors;
  // Start is called before the first frame update
  void Start()
  {
    intensitys = new float[] {
      0.01f, 0.02f, 0.05f, 0.08f,
      0.1f, 0.2f, 0.5f,0.8f,
      1, 2, 5, 8,
      10
    };
    colors = new Color[] {
      new Color(1f,1f,1f),
      new Color(1f,0.0f,0.0f),
      new Color(0.0f,1f,0.0f),
      new Color(0.0f,0.0f,1f),
    };

    int iNum = 0;
    float spacing = 1.2f;
    Vector3 offset = new Vector3(
        (intensitys.Length - 1) * spacing / 2,
        (colors.Length) * spacing / 2
      );
    foreach (var intensity in intensitys)
    {
      for (int c = 0; c <= colors.Length; c++)
      {
        Vector3 position = new Vector3(
            spacing * iNum,
            spacing * c
          ) - offset + transform.position;
        GameObject go = Instantiate(spherePrefab, position, Quaternion.identity);
        go.transform.parent = transform;
        Material material = go.GetComponent<Renderer>().material;
        material.SetFloat("_Intensity", intensity);
        if (c < colors.Length)
        {
          material.SetColor("_Color", colors[c]);
        }
        else
        {
          material.SetTexture("_Texture", texture);
        }

      }
      iNum++;
    }
  }
}
