//
//  PTOpenGLViewController.h
//  PhysicsTest
//

#import "PTOpenGLView.h"

@protocol PTOpenGLViewControllerDelegate;


#pragma mark -
#pragma mark PTOpenGLViewController
#pragma mark -

@interface PTOpenGLViewController : NSViewController
   <PTOpenGLViewDelegate>
{
}

@property (nonatomic, assign)
IBOutlet id <PTOpenGLViewControllerDelegate> delegate;

@property (nonatomic)
NSInteger preferredFramesPerSecond;

@property (nonatomic, readonly)
NSInteger framesPerSecond;

@property (nonatomic, getter=isPaused)
BOOL paused;

@property (nonatomic, readonly)
NSInteger framesDisplayed;

@property (nonatomic, readonly)
NSTimeInterval timeSinceLastUpdate;

@property (nonatomic, readonly)
NSTimeInterval timeSinceLastDraw;

@end

#pragma mark -
#pragma mark PTOpenGLViewControllerDelegate
#pragma mark -

@protocol PTOpenGLViewControllerDelegate <NSObject>

@required
- (void)ptViewControllerUpdate:(PTOpenGLViewController *)controller;

@end
