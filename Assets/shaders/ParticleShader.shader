Shader "Custom/ParticleShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		
        //Define properties for Start and End Color
		_StartColor("Start Color", Color) = (1,1,1,1)
		_EndColor("End Color", Color) = (0,0,0,0)
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Opaque" }

        Blend One One
        ZWrite off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct appdata
            {
                float4 vertex : POSITION;
				float3 uv1 : TEXCOORD0;
            };

            struct v2f
            {   
                float4 vertex : SV_POSITION;
				
				float3 uv1 : TEXCOORD0;
            };

            sampler2D _MainTex;
			uniform float4 _StartColor;
			uniform float4 _EndColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv1.xy = v.uv1;
				o.uv1.z = v.uv1.z;
				v.vertex += sin(_Time.x * 10 + 2);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
				//fixed4 color = tex2D(_MainTex, i.uv1);
				float agePercentage = i.uv1.z;

				fixed4 color = tex2D(_MainTex, i.uv1);


				color = lerp(color *_StartColor, _EndColor * color.a, agePercentage);
				//color = _StartColor;


                return color;
            }
            ENDCG
        }
    }
}
