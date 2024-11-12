Shader "Unlit/01_Simple"
{
   Properties{
    //宣言＆初期値設定
    _Color("Color",Color)=(1,0,0,1)
   }

    SubShader
    {
       
        Pass
        {
            CGPROGRAM
            //頂点
            #pragma vertex vert
            //ピクセル
            #pragma fragment frag
           
            #include "UnityCG.cginc"
            //宣言した値を用意
            fixed4 _Color;

            float4 vert(float4 v:POSITION):SV_POSITION{
                float4 o;
                o=UnityObjectToClipPos(v);
                return o;
            }
         //表示する色を決定
            fixed4 frag(float4 i:SV_POSITION) : SV_TARGET
            {
                    fixed4 o=_Color;
                   return o;
            }

           
            ENDCG
        }
    }
}
