//
//  PTOpenGLViewController.m
//  PhysicsTest
//
//Copyright (c) 2012 Erik M. Buck
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


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
