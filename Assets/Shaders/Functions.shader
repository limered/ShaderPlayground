Shader "Hidden/First"
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
			
			float plot(float2 uv, float pct)
			{
				return  smoothstep(pct - 0.02, pct, uv.y) - smoothstep(pct, pct + 0.02, uv.y);
			}

			sampler2D _MainTex;
			uniform float2 size;
			uniform float fTime;

			fixed4 frag (v2f i) : SV_Target
			{
				float y = ceil(cos(i.uv.x+fTime)) + floor(cos(i.uv.x + fTime));

				float3 color = float3(y,y,y);
				float pct = plot(i.uv, y);
				color = (1.0 - pct)*color + pct*float3(0.0, 1.0, 0.0);

				return fixed4(color, 1.0);
			}
			ENDCG
		}
	}
}
