
cbuffer MatrixBuffer : register(b0)
{
	matrix worldMatrix;
	matrix viewMatrix;
	matrix projectionMatrix;
	matrix lightViewMatrix[2];
	matrix lightProjectionMatrix[2]; //need to update here to output multiple to the PS
};

struct InputType
{
    float4 position : POSITION;
    float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
};

struct OutputType
{
    float4 position : SV_POSITION;
    float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
    float4 lightViewPos[2] : TEXCOORD1; //need multiple light view positions
};


OutputType main(InputType input)
{
    OutputType output;

	// Calculate the position of the vertex against the world, view, and projection matrices. need matrices for each light!!!! then send these to pixel shader and ba da bing ba da boom
    output.position = mul(input.position, worldMatrix);
    output.position = mul(output.position, viewMatrix);
    output.position = mul(output.position, projectionMatrix);
    
	// Calculate the position of the vertice as viewed by the light source.
    output.lightViewPos[0] = mul(input.position, worldMatrix);
    output.lightViewPos[0] = mul(output.lightViewPos[0], lightViewMatrix[0]);
    output.lightViewPos[0] = mul(output.lightViewPos[0], lightProjectionMatrix[0]);
    
    output.lightViewPos[1] = mul(input.position, worldMatrix);
    output.lightViewPos[1] = mul(output.lightViewPos[1], lightViewMatrix[1]);
    output.lightViewPos[1] = mul(output.lightViewPos[1], lightProjectionMatrix[1]);


    output.tex = input.tex;
    output.normal = mul(input.normal, (float3x3)worldMatrix);
    output.normal = normalize(output.normal);

	return output;
}