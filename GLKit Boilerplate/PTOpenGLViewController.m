//
//  PTOpenGLViewController.m
//  PhysicsTest
//

#import "PTOpenGLViewController.h"

@interface PTOpenGLViewController ()
{
}

@property (strong, nonatomic)
NSTimer *timer;

@property (atomic, assign)
CVTimeStamp outputTime;

@property (atomic, assign)
NSTimeInterval lastUpdateTime;

@property (atomic, assign)
NSTimeInterval firstUpdateTime;

@property (nonatomic, readwrite)
NSInteger framesPerSecond;

@property (nonatomic, readwrite)
NSInteger framesDisplayed;

@property (nonatomic, readwrite)
NSTimeInterval timeSinceLastUpdate;

@property (nonatomic, readwrite)
NSTimeInterval timeSinceLastDraw;

@end

@implementation PTOpenGLViewController

/////////////////////////////////////////////////////////////////
// 
- (void) dealloc
{	
   [self.timer invalidate];
}


/////////////////////////////////////////////////////////////////
// 
- (void)awakeFromNib
{
    NSAssert([self.view isKindOfClass:[PTOpenGLView class]],
       @"Attempt to use PTOpenGLViewController without PTOpenGLView");
    
    PTOpenGLView *openGLView = (PTOpenGLView *)self.view;
    self.preferredFramesPerSecond = 30;
    openGLView.delegate = self;
    
    self.timer = [NSTimer timerWithTimeInterval:
          1.0 / MAX(1, self.preferredFramesPerSecond)
       target:self
       selector:@selector(_ptPrepareToDraw:)
       userInfo:nil
       repeats:YES];
   [[NSRunLoop mainRunLoop] addTimer:self.timer
      forMode:NSRunLoopCommonModes];
}


/////////////////////////////////////////////////////////////////
// 
- (void)update
{
}


/////////////////////////////////////////////////////////////////
// 
- (void)_ptPrepareToDraw:(id)dummy
{
   @autoreleasepool {
      if(0 >= self.lastUpdateTime)
      {
         self.firstUpdateTime = [NSDate timeIntervalSinceReferenceDate];
         self.lastUpdateTime = self.firstUpdateTime;
      }
      else
      {
         NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
         self.timeSinceLastUpdate = (currentTime - self.lastUpdateTime);
         self.timeSinceLastDraw = (currentTime - self.lastUpdateTime);
         self.framesPerSecond = 1.0 / self.timeSinceLastUpdate;
         self.framesDisplayed++;
            
         [self update];
         [self.view display];

         self.lastUpdateTime = currentTime;
      }
   }
}


/////////////////////////////////////////////////////////////////
// 
- (void)initGL
{
	// Make this openGL context current to the thread
	// (i.e. all openGL on this thread calls will go to this context)
	[[(PTOpenGLView *)self.view openGLContext] makeCurrentContext];
	
	// Synchronize buffer swaps with vertical refresh rate
	GLint swapInt = 1;
	[[(PTOpenGLView *)self.view openGLContext] setValues:&swapInt
      forParameter:NSOpenGLCPSwapInterval];
}


/////////////////////////////////////////////////////////////////
// 
- (void)prepareOpenGL
{
	// Make all the OpenGL calls to setup rendering  
	//  and build the necessary rendering objects
	[self initGL];
}


@end
