Shader "SF/Alpha opacity Detail" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
	_Detail ("Detail (RGB)", 2D) = "gray" {}
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	AlphaTest Greater .01
	ColorMask RGB
	Cull off Lighting Off ZWrite Off Fog { Mode Off }
	BindChannels {
		Bind "Color", color
		Bind "Vertex", vertex
		Bind "TexCoord", texcoord
	}
	
	// ---- Dual texture cards
	SubShader {
		Pass {
			SetTexture [_MainTex] {
				constantColor [_TintColor]
				combine constant * primary
			}
			SetTexture [_MainTex] {
				combine texture * previous DOUBLE
			}
			SetTexture [_Detail] { 
				combine previous * texture DOUBLE
			}
		}
	}
	
	// ---- Single texture cards (does not do color tint)
	//SubShader {
		//Pass {
			//SetTexture [_MainTex] {
				//combine texture * primary
			//}
		//}
	//}
}
}
