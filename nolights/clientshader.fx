//-- Declare the textures. These are set using dxSetShaderValue( shader, "Tex0", texture )
texture Tex0;
texture Tex1;
 
//-- Declare a user variable. This can be set using dxSetShaderValue( shader, "PositionOfCheese", 1, 2, 3 )
float3 PositionOfCheese;
 
//-- These variables are set automatically by MTA
float4x4 World;
float4x4 View;
float4x4 Projection;
float4x4 WorldViewProjection;
float Time;
 
 
//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture = (Tex0);
};
 
 
sampler MeshTextureSampler = 
sampler_state
{
    Texture = (Tex0);
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
};

 
//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION;
    float4 Diffuse  : COLOR0;
    float2 TexCoord : TEXCOORD0;
};
 
//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse  : COLOR0;
  float2 TexCoord : TEXCOORD0;
};
 
 
//-----------------------------------------------------------------------------
//-- VertexShaderExample
//--  1. Read from VS structure
//--  2. Process
//--  3. Write to PS structure
//-----------------------------------------------------------------------------
 
 
//-----------------------------------------------------------------------------
//-- PixelShaderExample
//--  1. Read from PS structure
//--  2. Process
//--  3. Return pixel color
//-----------------------------------------------------------------------------
float4 PixelShaderExample(PSInput PS) : COLOR0
{
    //-- Modify the texture coord to make the image look all wobbly
   // PS.TexCoord.y += sin(PS.TexCoord.y * 100 + Time * 10) * 0.03;
  
    //-- Grab the pixel from the texture
    float4 finalColor = tex2D(MeshTextureSampler, PS.TexCoord);
 
    //-- Apply color tint
    finalColor = finalColor * PS.Diffuse;
 
    return finalColor;
}
 
 
//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------
 
//--
//-- MTA will try this technique first:
//--
technique detail
{
    pass P0
    {
        PixelShader  = compile ps_2_0 PixelShaderExample();
    }
}
 
//--
//-- And if the preceding technique will not validate on
//-- the players computer, MTA will try this one:
//--
technique simple
{
    pass P0
    {
        //-- Set up texture stage 0
        Texture[0] = Tex0;
        ColorOp[0] = SelectArg1;
        ColorArg1[0] = Texture;
        AlphaOp[0] = SelectArg1;
        AlphaArg1[0] = Texture;
 
        //-- Disable texture stage 1
        ColorOp[1] = Disable;
        AlphaOp[1] = Disable;
    }
}