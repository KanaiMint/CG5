Shader "Unlit/06_01_Aces"
{
  Properties
  {
    _MainTex("Texture", 2D) = "white" {}
  }
  SubShader
  {
    Tags { "RenderType" = "Opaque" }
    LOD 100

    Pass
    {
      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag

      #include "UnityCG.cginc"

      struct appdata
      {
        float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
      };

      struct v2f
      {
        float2 uv : TEXCOORD0;
        float4 vertex : SV_POSITION;
      };

      sampler2D _MainTex;
      v2f vert(appdata v)
      {
        v2f o;
        o.vertex = UnityObjectToClipPos(v.vertex);
        o.uv = v.uv;
        return o;
      }

      float GetLuminance(float3 col)
      {
        float3 luminanceCoefficient = float3(0.299, 0.587, 0.114);
        return dot(col, luminanceCoefficient);
      }

      float3 MulAcesInputMatrix(float3 col){
          float3x3 aceInputMatrix = 
          float3x3(
              0.59719f, 0.35458f,   0.04823f,
              0.07600f, 0.90834f,   0.01566f,
              0.02840f, 0.13383f,   0.83777f
          );
            return mul(aceInputMatrix,col);
      }

      float3 RRTAndODTFit(float3 v){
          float3 a=v*(v+0.0245786)-0.000090537;
          float3 b = v*(0.983729*v+0.4329510)+0.238081;
          return a/b;
      }

      float3 MulAcesOutputMatrix(float3 col){
          float3x3 aceOutputMatrix=float3x3(
               1.60475f, -0.53108f,-0.07367f,
              -0.10208f,  1.10813f,-0.00605f,
              -0.00327f, -0.07276f, 1.07602f
              );
              return mul(aceOutputMatrix,col);
      }

      float Linear(float lIn)
      {
        return lIn;
      }

      fixed4 frag(v2f i) : SV_Target
      {
        fixed4 col = tex2D(_MainTex, i.uv);
        float3 aceInput = MulAcesInputMatrix(col.rgb);
        float3 transpose = RRTAndODTFit(aceInput);
        float3 aceOutput = MulAcesOutputMatrix(col.rgb);
        fixed4 result = fixed4(aceOutput,1);

        return result;
      }
      ENDCG
    }
  }
}
