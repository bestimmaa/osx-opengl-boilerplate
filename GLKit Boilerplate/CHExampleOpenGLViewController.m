//
//  CHExampleOpenGLViewController.m
//  GLKit Boilerplate
//
//  Created by Christoph Halang on 22/05/15.
//  Copyright (c) 2015 Christoph Halang. All rights reserved.
//

#import "CHExampleOpenGLViewController.h"
#import "PTEffect.h"
#import "cube.h"

#undef __gl_h_
#import <GLKit/GLKit.h>

@interface CHExampleOpenGLViewController ()
//@property (strong, nonatomic, readwrite)
//   GLKBaseEffect *baseEffect;
@property (strong, nonatomic, readwrite)
PTEffect *baseEffect;
@end

@implementation CHExampleOpenGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark -

/////////////////////////////////////////////////////////////////
//
- (void)prepareOpenGL;
{
    [super prepareOpenGL];
    
    
    // Create a base effect that provides standard OpenGL ES 2.0
    // Shading Language programs and set constants to be used for
    // all subsequent rendering
    //self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect = [[PTEffect alloc] init];
    
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
    
    // Configure a light
    self.baseEffect.lightModelAmbientColor =
    GLKVector4Make(
                   0.0f, // Red
                   0.0f, // Green
                   0.0f, // Blue
                   1.0f);// Alpha
    
    // Configure initial modelview matrix
    self.baseEffect.transform.modelviewMatrix =
    GLKMatrix4MakeLookAt(
                         9.8, 9.8, 6.0, // Eye position
                         0.0, 1.0, 0.0,  // Look-at position
                         0.0, 1.0, 0.0); // Up direction
    
    
    // Become the first responder to receive motion events
    [self becomeFirstResponder];
    
    // Set the background color stored in the current context
    glClearColor(0.0f, 0.3f, 0.0f, 1.0f); // background color
}

/////////////////////////////////////////////////////////////////
//
- (void)ptOpenGLViewDidReshape:(PTOpenGLView *)view;
{
    const GLfloat    width = [view bounds].size.width;
    const GLfloat    height = [view bounds].size.height;
    
    NSParameterAssert(0 < height);
    
    // Tell OpenGL ES to draw into the full backing area
    glViewport(0, 0, width, height);
    
    // Calculate the aspect ratio for the scene and setup a
    // perspective projection
    const GLfloat  aspectRatio =
    width / height;
    
    // Set the projection to match the aspect ratio
    self.baseEffect.transform.projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(35.0f),// Standard field of view
                              aspectRatio,
                              0.2f,     // Don't make near plane too close
                              200.0f); // Far arbitrarily far enough to contain scene   
}

/////////////////////////////////////////////////////////////////
//
- (void)update
{

}

/////////////////////////////////////////////////////////////////
//
- (void)ptOpenGLView:(PTOpenGLView *)view
          drawInRect:(NSRect)rect;
{
    // Configure a light
    self.baseEffect.light0.position =
    GLKVector4Make(
                   -0.6f,
                   1.0f,
                   0.4f,
                   0.0f); // Directional light
    self.baseEffect.light0.enabled = NO;
    self.baseEffect.light0.transform = self.baseEffect.transform;
    
    [self.baseEffect prepareToDraw];
    
    // Clear Frame Buffer (erase previous drawing)
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    [self drawSomething];
}

/////////////////////////////////////////////////////////////////
// Draw all the box objects currently being simulated
- (void)drawSomething
{
    // Save the current modelview matrix
    GLKMatrix4 savedModelviewMatrix =
    self.baseEffect.transform.modelviewMatrix;
    
    // Enable use of positions
    glEnableVertexAttribArray(
                              GLKVertexAttribPosition);
    
    glVertexAttribPointer(
                          GLKVertexAttribPosition,
                          3,                   // three components per vertex
                          GL_FLOAT,            // data is floating point
                          GL_FALSE,            // no fixed point scaling
                          3 * sizeof(float), // no gaps in data
                          cubeVerts);
    
    // Enable use of normals
    glEnableVertexAttribArray(
                              GLKVertexAttribNormal);
    
    glVertexAttribPointer(
                          GLKVertexAttribNormal,
                          3,                   // three components per vertex
                          GL_FLOAT,            // data is floating point
                          GL_FALSE,            // no fixed point scaling
                          3 * sizeof(float), // no gaps in data
                          cubeNormals);
    
    self.baseEffect.transform.modelviewMatrix =
    GLKMatrix4Multiply(savedModelviewMatrix,
                       GLKMatrix4Identity);
    
    [self.baseEffect prepareToDraw];
    
    // Draw triangles using the first three vertices in the
    // currently bound vertex buffer
    glDrawArrays(GL_TRIANGLES,
                 0,  // Start with first vertex in currently bound buffer
                 cubeNumVerts);
    
    // Restore the current modelview matrix
    self.baseEffect.transform.modelviewMatrix = 
    savedModelviewMatrix;
}

@end
