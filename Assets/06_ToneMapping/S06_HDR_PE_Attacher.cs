using System.ComponentModel;
using UnityEngine;

public class S06_HDR_PE_Attacher : MonoBehaviour
{
  public Shader tonemappingShader;
  public Shader harationCheckShader;
  private Shader preShader;
  public Material tonemappingMaterial;
  private Material halationCheckMaterial;


  private void Awake()
  {
    halationCheckMaterial = new Material(harationCheckShader);
    UpdateMaterial();
  }

  private void UpdateMaterial()
  {
    preShader = tonemappingShader;
    tonemappingMaterial = new Material(tonemappingShader);
  }

  private void Update()
  {
    if (tonemappingShader != preShader)
    {
      UpdateMaterial();
    }
  }

  private void OnRenderImage(RenderTexture source, RenderTexture destination)
  {
    RenderTexture tmp = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGBHalf);

    if (tonemappingMaterial == null)
    {
      Graphics.Blit(source, tmp);
    }
    else
    {
      Graphics.Blit(source, tmp, tonemappingMaterial);
    }
    Graphics.Blit(tmp, destination, halationCheckMaterial);
    RenderTexture.ReleaseTemporary(tmp);
  }
}
