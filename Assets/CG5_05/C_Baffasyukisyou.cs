using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Baffasyukisyou : MonoBehaviour
{
    public Shader shader;
    Material material;

    // Start is called before the first frame update
    private void Awake()
    {
        material = new Material(shader);//シェーダーを割り当てたマテリアルの動的生成
    }

    // Update is called once per frame
  
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        RenderTexture buffer =
        RenderTexture.GetTemporary(source.width / 2, source.height / 2, 0, source.format);
        Graphics.Blit(source, buffer);
        Graphics.Blit(buffer, destination);
        RenderTexture.ReleaseTemporary(buffer);

    }
}
