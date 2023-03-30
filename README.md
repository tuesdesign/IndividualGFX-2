# IndividualGFX-2

## Shader #1: Wave - Toon ramp / Square Wave
This wave shader is a modified version of the one made in the lecture. The wave uses vertex displacement to shift the geometry in a wave-like pattern. I have modified this shader by adding a simple toon ramp illumination model and by using the round() function to modify the wave function to make it step to the nearest integer value. Paired with an increased polycount in the base plane, it creates a convincing square wave effect.


## Shader #2: Shadows - Scrolling / Custom Shadow Texture
This Shadow is a modified version of the shadow shader made in the lecture and tutorial. This shader samples the shadow map and uses that value as a mask to layer in a dedicated shadow texture. I modified this shader by making the shadow be textured, scrolling and moving over time.

## Shader #3: Outline - Chromatic Cycling 
This outline effect is a modified version of the outline shader made in the lecture. The shader works by creating a duplicate mesh rendered behind the main mesh, with extruded faces. My version changes the colou over time to create a rainbow outline effect.

![forward_deferred_Explain1](https://user-images.githubusercontent.com/64446905/228612767-00a130f0-28b2-474a-94ad-f8b130eb7370.png)

![codeExplain1](https://user-images.githubusercontent.com/64446905/228612822-dc6f1b04-7d6a-4e8e-b050-884c2832d8b3.png)

![shaderExplain1](https://user-images.githubusercontent.com/64446905/228612846-0cc9927b-7cb2-4a1f-b652-06df99acc0cf.png)
