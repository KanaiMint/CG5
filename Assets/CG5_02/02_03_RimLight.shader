Shader "Unlit/04_Phong"
{
   Properties{
    //宣言＆初期値設定

    _MainTex("texture",2D) = "white"{}
    _Color("Color",Color) = (1,1,1,1)
    rim_Color("Color",Color) = (1,0,0,1)
   }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            //#pragma multi_compile_fog

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            fixed4 _Color;
            fixed4 rim_Color;
            

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {               
                float4 vertex : SV_POSITION;
                float3 worldPosition : TEXCOORD1;
                float3 normal:NORMAL;
                float2 uv : TEXCOORD0;
            };       

           sampler2D _MainTex;
            float4 _MainTex_ST;
            v2f vert (appdata v)
            {
                 v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);//スクリーン返還
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPosition=mul(unity_ObjectToWorld,v.vertex);//ワールド座標返還

                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //Texture
                float2 tiling = _MainTex_ST.xy;
                float2 offset = _MainTex_ST.zw;
                //_Color = tex2D(_MainTex,i.uv*tiling+offset);
                
                //Lambert陰影
                //_WorldSpaceLightPos0で光源の位置を取得できる
                float intensity=saturate(dot(normalize(i.normal),_WorldSpaceLightPos0));
                
                //fixed4   color = (1,1,1,1);
                fixed4   color = _Color;
                fixed4   diffuse =  color * intensity *_LightColor0;
                
                //Specular鏡面反射
                float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);
                float3 lightDir = normalize(_WorldSpaceLightPos0);
                i.normal = normalize(i.normal);
                float3 reflectDir = -lightDir+2*i.normal*dot(i.normal,lightDir);
                fixed4 specular = pow(saturate(dot(reflectDir,eyeDir)),20)*_LightColor0;

                //Ambient環境光
                fixed4 ambient = _Color*0.3*_LightColor0;

                //Phong反射モデル
                fixed4 phong = ambient+diffuse+specular;
               
                //toon
                fixed4 toon = color * step(0.3f,intensity) *_LightColor0+ambient ;
                
                //リムライト
                fixed4 rim = pow((dot(i.normal,-eyeDir)+1.0f),1.0f)*rim_Color;

                return phong+rim   ;

            }
            ENDCG
        }
    }
}
