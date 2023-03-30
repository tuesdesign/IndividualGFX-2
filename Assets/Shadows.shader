Shader "Custom/Shadows"
{
        Properties
        {
            _Color("Color", Color) = (1,1,1,1)
            _MainTex("Albedo (RGB)", 2D) = "white" {}
            _ShadowTex("Shadow (RGB)", 2D) = "white" {}
            _Glossiness("Smoothness", Range(0,1)) = 0.5
            _Metallic("Metallic", Range(0,1)) = 0.0
        }
            SubShader{

                Pass
                {
                    Tags {"Queue" = "Transparent"}

                    CGPROGRAM
                    #pragma vertex vert
                    #pragma fragment frag
                    #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
                    #include "UnityCG.cginc"
                    #include "UnityLightingCommon.cginc"

                    #include "Lighting.cginc"
                    #include "AutoLight.cginc"
                    struct appdata {
                        float4 vertex : POSITION;
                        float3 normal : NORMAL;
                        float4 texcoord : TEXCOORD0;
                    };

                    struct v2f {
                        float2 uv : TEXCOORD0;
                        fixed4 diff : COLOR0;
                        float4 pos : SV_POSITION;
                        SHADOW_COORDS(1)
                            //SHADOW COORDS
                            };

                            v2f vert(appdata v) {
                                v2f o;
                                o.pos = UnityObjectToClipPos(v.vertex);
                                o.uv = v.texcoord;

                                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                                o.diff = nl * _LightColor0;
                                TRANSFER_SHADOW(o);

                                return o;
                            }

                            sampler2D _MainTex;
                            sampler2D _ShadowTex;
                            float4 _ShadowTex_ST;
                            float4 _Color;

                            fixed4 frag(v2f i) : SV_Target
                            {
                                fixed4 col = tex2D(_MainTex, i.uv);
                                fixed shadow = SHADOW_ATTENUATION(i);
                                col.rgb *= i.diff * shadow;

                                fixed4 shadowColor = (1, 0, 0, 1);
                                float2 _ShadowTexUV = i.uv;
                                _ShadowTexUV.x *= _ShadowTex_ST.x *= sin(_Time);
                                _ShadowTexUV.y *= _ShadowTex_ST.y *= sin(_Time);

                                fixed4 finalCol = col * shadow + tex2D(_ShadowTex, _ShadowTexUV) * (1 - shadow);

                                //col.rgb = shadowColour;
                                //col *= 0.0f;
                                return finalCol;
                            }
                        ENDCG
                        }


                        Pass
                        {
                            Tags {"LightMode" = "ShadowCaster"}

                            CGPROGRAM
                            #pragma vertex vert
                            #pragma fragment frag
                            #pragma multi_compile_shadowcaster
                            #include "UnityCG.cginc"

                            struct appdata {
                                float4 vertex : POSITION;
                                float3 normal : NORMAL;
                                float4 texcoord : TEXCOORD0;
                            };

                            struct v2f {
                                V2F_SHADOW_CASTER;

                            };

                            v2f vert(appdata v) {
                                v2f o;
                                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                                return o;
                            }

                            float4 frag(v2f i) : SV_Target{


                                SHADOW_CASTER_FRAGMENT(i)


                            }
                            ENDCG
                        }
            }
    }
