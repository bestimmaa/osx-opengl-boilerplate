//
//  PTOpenGLView.m
//  PhysicsTest
//

#import "PTOpenGLView.h"

#undef __gl_h_
#import <GLKit/GLKit.h>


@interface PTOpenGLView ()
{
}

@end


@implementation PTOpenGLView

/////////////////////////////////////////////////////////////////
// 
- (void)prepareOpenGL;
{
   [super prepareOpenGL];

   [self.delegate prepareOpenGL];
}


/////////////////////////////////////////////////////////////////
// 
- (void)reshape
{
	[[self openGLContext] makeCurrentContext];

   if([self.delegate respondsToSelector:@selector(ptOpenGLViewDidReshape:)])
   {
      [self.delegate ptOpenGLViewDidReshape:self];
   }
}


/////////////////////////////////////////////////////////////////
// 
- (void)drawRect:(NSRect)dirtyRect
{
	[[self openGLContext] makeCurrentContext];

   if([self.delegate respondsToSelector:@selector(ptOpenGLView:drawInRect:)])
   {
      [self.delegate ptOpenGLView:self drawInRect:dirtyRect];
   }
   else
   {
   }
	
   glFlush();
	CGLFlushDrawable([[self openGLContext] CGLContextObj]);
}


/////////////////////////////////////////////////////////////////
// 
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
