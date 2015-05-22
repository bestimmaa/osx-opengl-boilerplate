//
//  PTOpenGLView.h
//  PhysicsTest
//

#import <Cocoa/Cocoa.h>

@protocol PTOpenGLViewDelegate;


@interface PTOpenGLView : NSOpenGLView

@property (weak, nonatomic, readwrite)
id <PTOpenGLViewDelegate> delegate;

@end


@protocol PTOpenGLViewDelegate <NSObject>

@required
- (void)prepareOpenGL;

@optional
- (void)ptOpenGLView:(PTOpenGLView *)view
   drawInRect:(NSRect)rect;
- (void)ptOpenGLViewDidReshape:(PTOpenGLView *)view;

@end
