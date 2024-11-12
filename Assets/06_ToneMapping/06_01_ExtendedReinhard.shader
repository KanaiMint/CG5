Shader "Unlit/06_01_ExtendedReinhard"
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

      float ExtendedReinhard(float lIn,float maxWhite){
        return lIn/(1+lIn)*(1+(lIn/(maxWhite*maxWhite)));
      }

      float Linear(float lIn)
      {
        return ExtendedReinhard(lIn,2);
      }

      fixed4 frag(v2f i) : SV_Target
      {
        fixed4 col = tex2D(_MainTex, i.uv);
        float lIn = GetLuminance(col);
        float lOut = Linear(lIn);
        return col * (lOut / lIn);
      }
      ENDCG
    }
  }
}