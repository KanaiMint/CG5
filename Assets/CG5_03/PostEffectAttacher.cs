using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffectAttacher : MonoBehaviour
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
        //加工している場所
        Graphics.Blit(source, destination, material);
    }

}
