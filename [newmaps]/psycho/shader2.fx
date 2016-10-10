//
// shader.fx
// From the shader_tex_list resource

float Time : TIME;

// Make everything all flashy!
float4 GetColor()
{
    return float4( cos(Time*50), cos(Time*50), cos(Time*50), 1 );
}

//-----------------------------------------------------------------------------
// Techniques
//-----------------------------------------------------------------------------
technique tec0
{
    pass P0
    {
        MaterialAmbient = GetColor();
        MaterialDiffuse = GetColor();
        MaterialEmissive = GetColor();
        MaterialSpecular = GetColor();

        AmbientMaterialSource = Material;
        DiffuseMaterialSource = Material;
        EmissiveMaterialSource = Material;
        SpecularMaterialSource = Material;

        ColorOp[0] = SELECTARG1;
        ColorArg1[0] = Diffuse;

        AlphaOp[0] = SELECTARG1;
        AlphaArg1[0] = Diffuse;

        Lighting = true;
    }
}


