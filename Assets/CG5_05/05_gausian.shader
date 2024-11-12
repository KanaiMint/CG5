Shader "Unlit/05_gausian"
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
fixed Gaussian(float2 drawUV,float2 pickUV,float sigma){
                float d=distance(drawUV,pickUV);
                return exp(-(d*d)/(2*sigma*sigma+0.0001));
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
            
            //UVシフトブラー
            // float _ShiftWidth=0.005;
            // float _ShiftNum=3;

            // fixed4 col = fixed4(0,0,0,0);
            // float num=0;
            // [loop]
            // for(fixed py=-_ShiftNum/2;py<=_ShiftNum/2;py++){
            //     [loop]
            //     for(fixed px=_ShiftNum/2;px<=_ShiftNum/2;px++){
            //         col+=tex2D(_MainTex,i.uv+float2(px,py)*_ShiftWidth);
            //         num++;
            //     }
            // }
            // col.rgb=col.rgb/num;
            // col.a=1;


            //ガウシアンブラー
            

            float totalWeight=0,_Sigma=0.005,_StepWidth=0.001;
            float4 col =fixed4(0,0,0,0);

            for(float py=-_Sigma*2;py<=_Sigma*2;py+=_StepWidth){
                for(float px=-_Sigma*2;px<=_Sigma*2;px+=_StepWidth){
                float2 pickUV = i.uv+float2(px,py);
                fixed weight = Gaussian(i.uv,pickUV,_Sigma);
                col += tex2D(_MainTex,pickUV)*weight;
                totalWeight+=weight;

            }
            }
            col.rgb=col.rgb/totalWeight;
            col.a=1;



               return col;
            }
            ENDCG
        }
    }

}
