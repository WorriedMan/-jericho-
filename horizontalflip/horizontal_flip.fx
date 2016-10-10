
texture ScreenTexture;	
sampler screenSampler = sampler_state
{
	Texture = <ScreenTexture>;
};

float4 HorizontalFlip( float2 Tex : TEXCOORD0 ) : COLOR0
{
	Tex.x = 1.0f - Tex.x;
	float4 screen = tex2D( screenSampler, Tex );
	/*
	float grey = screen.r + screen.g + screen.b;
	grey /= 3;
	screen = grey;
	screen.a = 1.0f;
	 */
	return screen;
};

technique Flip
{
	pass P1
	{
		PixelShader = compile ps_2_0 HorizontalFlip();
	}
}

