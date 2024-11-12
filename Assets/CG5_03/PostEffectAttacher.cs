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
        material = new Material(shader);//�V�F�[�_�[�����蓖�Ă��}�e���A���̓��I����
    }

    // Update is called once per frame
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        //���H���Ă���ꏊ
        Graphics.Blit(source, destination, material);
    }

}
