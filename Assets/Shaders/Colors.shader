Shader "Hidden/Colors"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			#define PI 3.141592653589793
			#define HALF_PI 1.5707963267948966

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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			uniform float u_time;

			

			fixed4 frag (v2f i) : SV_Target
			{
				float3 colorA = float3(0.000, 0.000, 1.000);
				float3 colorB = float3(1.000, 0.000, 0.000);

				float t = abs(frac(u_time));

				float pct = 1.0 - sqrt(1.0 - t * t);

				float3 color = float3(0.0, 0.0, 0.0);

				color = lerp(colorA, colorB, pct);

				return fixed4(color, 1.0);
			}
			ENDCG
		}
	}
}
