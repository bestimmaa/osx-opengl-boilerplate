//
//  PTEffect.m
//  PhysicsTest
//

#import "PTEffect.h"

#undef __gl_h_
#import <GLKit/GLKit.h>

/////////////////////////////////////////////////////////////////
// GLSL program uniform indices.
enum
{
   PTMVPMatrix,
   PTNormalMatrix,
   PTLightModelAmbientColor,
   PTLight0Position,
   PTLight0DiffuseColor,
   PTNumUniforms
};


@interface PTEffect ()
{
   GLint uniforms[PTNumUniforms];
}

@property (strong, nonatomic, readwrite)
   GLKEffectPropertyTransform *transform;

@property (strong, nonatomic, readwrite)
   GLKEffectPropertyLight *light0;

@end



@implementation PTEffect

#pragma mark -  Lifecycle

/////////////////////////////////////////////////////////////////
//  
- (id)init;
{
   if(nil != (self = [super init]))
   {
      self.transform =
         [[GLKEffectPropertyTransform alloc] init];
         
      self.light0 =
         [[GLKEffectPropertyLight alloc] init];
   }
   
   return self;
}


#pragma mark -  OpenGL ES 2 shader compilation

- (void)bindAttribLocations;
{
   glBindAttribLocation(
      self.program, 
      UtilityVertexAttribPosition, 
      "a_position");
   glBindAttribLocation(
      self.program, 
      UtilityVertexAttribNormal, 
      "a_normal");
}


- (void)configureUniformLocations
{
   uniforms[PTMVPMatrix] = glGetUniformLocation(
      self.program, 
      "u_mvpMatrix");
   uniforms[PTNormalMatrix] = glGetUniformLocation(
      self.program, 
      "u_normalMatrix");
   uniforms[PTLightModelAmbientColor] = glGetUniformLocation(
      self.program, 
      "u_lightModelAmbientColor");
   uniforms[PTLight0Position] = glGetUniformLocation(
      self.program, 
      "u_light0Position");
   uniforms[PTLight0DiffuseColor] = glGetUniformLocation(
      self.program, 
      "u_light0DiffuseColor");
}


#pragma mark -  Render Support

/////////////////////////////////////////////////////////////////
//
- (void)prepareOpenGL
{
   [self loadShadersWithName:@"PTEffectShader"];
}


/////////////////////////////////////////////////////////////////
//
- (void)updateUniformValues
{
   [self prepareModelview];
      
   // Lighting
   glUniform4fv(uniforms[PTLight0Position], 1,
      self.light0.position.v);
   glUniform4fv(uniforms[PTLightModelAmbientColor], 1,
      self.lightModelAmbientColor.v);
   glUniform4fv(uniforms[PTLight0DiffuseColor], 1,
      self.light0.diffuseColor.v);
}


/////////////////////////////////////////////////////////////////
// This method exists as a minor optimization to update the 
// modelview matrix and normal matrix without updating any other
// uniform values used by the Shading Language program.
- (void)prepareModelview
{
   // Pre-calculate the mvpMatrix and normal matrix
   GLKMatrix4 modelViewProjectionMatrix = 
      GLKMatrix4Multiply(
         self.transform.projectionMatrix,
         self.transform.modelviewMatrix);
         
   glUniformMatrix4fv(uniforms[PTMVPMatrix], 1, 0, 
      modelViewProjectionMatrix.m);

   GLKMatrix3 normalMatrix =
      self.transform.normalMatrix;
   
   glUniformMatrix3fv(uniforms[PTNormalMatrix], 1, 
      GL_FALSE, normalMatrix.m);
}

@end
