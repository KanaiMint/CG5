Shader "Unlit/PostEffect"
{
    Properties
    {
        _MainTex ("MainTex", 2D) = "" {}
    }
    SubShader
    {
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
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
               
               //グレースケール
               fixed sepia = 0.1f;
               fixed grayscale=dot(col,float3(0.299,0.587,0.114));
               fixed4 color = fixed4(grayscale+sepia,grayscale,grayscale-sepia,1);
               
               //スキャンノイズ
            //    float _Speed = 0.1;
            //    float _Width = 1.13;
            //    float _Power = 0.5;
            //    float sbTime = -frac(_Time.y*_Speed);
            //    float seTime = sbTime+_Width;
            //    float2 uv_ =float2(i.uv.x+sin(smoothstep(sbTime,seTime,i.uv.y)*2*3.14159)*_Power,i.uv.y);
            //     col=tex2D(_MainTex,uv_);

               //RGBシフト
               // float shift=0.005f;
               // fixed r= tex2D(_MainTex,i.uv+float2(-shift,0)).r; 
               // fixed g= tex2D(_MainTex,i.uv+float2(0,0)).g; 
               // fixed b= tex2D(_MainTex,i.uv+float2(shift,0)).b; 
               //fixed4 col =fixed4(1-r,1-g,1-b,1);

               //モザイク
            //    float density =5;
            //    col = tex2D(_MainTex,
            //        floor(i.uv * _ScreenParams.xy/ density ) * density / _ScreenParams.xy);

               return color;
            }
            ENDCG
        }
    }
}
