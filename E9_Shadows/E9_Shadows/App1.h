// Application.h
#ifndef _APP1_H
#define _APP1_H

// Includes
#include "DXF.h"	// include dxframework
#include "TextureShader.h"
#include "ShadowShader.h"
#include "DepthShader.h"

class App1 : public BaseApplication
{
public:

	App1();
	~App1();
	void init(HINSTANCE hinstance, HWND hwnd, int screenWidth, int screenHeight, Input* in, bool VSYNC, bool FULL_SCREEN);

	bool frame();

protected:
	bool render();
	void depthPass();
	void depthPassRed();
	void windowPass();
	void finalPass();
	void gui();

private:
	TextureShader* textureShader;
	PlaneMesh* mesh;
	SphereMesh* sphereMesh;
	CubeMesh* cubeMesh;


	OrthoMesh* orthoMesh;
	RenderTexture* renderTexture;

	Light* light;
	Light* lightRed; //think this is better, making an array in here seems bad

	AModel* model;
	ShadowShader* shadowShader;
	DepthShader* depthShader;

	ShadowMap* shadowMap;
	ShadowMap* shadowMapRed;
};

#endif