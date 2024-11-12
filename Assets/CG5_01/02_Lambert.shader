Shader "Unlit/02_Lambert"
{
  Properties{
    //宣言＆初期値設定
    _Color("Color",Color)=(1,1,1,1)
   }
    SubShader
    {
      
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            fixed4 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };           

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //_WorldSpaceLightPos0で光源の位置を取得できる
              float intensity=saturate(dot(normalize(i.normal),_WorldSpaceLightPos0));

               //fixed4   color = (1,1,1,1);
               fixed4   color = _Color;
               fixed4   diffuse = color * intensity *_LightColor0;
                return diffuse;
            }
            ENDCG
        }
    }
}
