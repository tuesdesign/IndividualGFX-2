Shader "Custom/Outline"
{
    Properties
    {
        _OutlineColor("Outline Color", Color) = (0,0,0,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Outline("Outline Width", Range(0,10)) = 0.05
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }

            CGPROGRAM

            // Physically based Standard lighting model, and enable shadows on all light types
            #pragma surface surf Lambert

            struct Input
            {
                float2 uv_MainTex;
            };

            sampler2D _MainTex;
            fixed4 _OutlineColor;

            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;
            }

            ENDCG
            Pass
            {
                Cull Front
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                struct appdata {
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                };

                struct v2f {
                    float4 pos : SV_POSITION;
                    fixed4 color : COLOR;
                };

                float _Outline;
                float4 _OutlineColor;

                v2f vert(appdata v) {
                    v2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                    float2 offset = TransformViewToProjection(norm.xy);

                    o.pos.xy += offset * o.pos.z * _Outline;
                    o.color = _OutlineColor * sin(_Time);
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    return i.color;
                }
                    ENDCG
            }
        }
            FallBack "Diffuse"
}
