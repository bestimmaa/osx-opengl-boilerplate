//
//  UtilityModelShader.vsh
//  
//

#define highp
#define lowp


/////////////////////////////////////////////////////////////////
// VERTEX ATTRIBUTES
/////////////////////////////////////////////////////////////////
attribute vec3 a_position;
attribute vec3 a_normal;

/////////////////////////////////////////////////////////////////
// UNIFORMS
/////////////////////////////////////////////////////////////////
uniform highp mat4      u_mvpMatrix;
uniform highp mat3      u_normalMatrix;
uniform lowp  vec4      u_lightModelAmbientColor;
uniform highp vec4      u_light0Position;
uniform highp vec4      u_light0DiffuseColor;

/////////////////////////////////////////////////////////////////
// Varyings
/////////////////////////////////////////////////////////////////
varying lowp vec4       v_lightColor;


void main()
{
   // Lighting
   lowp vec3 normal = normalize(u_normalMatrix * a_normal);
   lowp float nDotL = max(
      dot(normal, normalize(u_light0Position.xyz)), 0.0);
   v_lightColor = (nDotL * u_light0DiffuseColor) + 
      u_lightModelAmbientColor;
   
   gl_Position = u_mvpMatrix * vec4(a_position, 1.0); 
}
