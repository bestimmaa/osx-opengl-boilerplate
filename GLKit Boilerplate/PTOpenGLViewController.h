//
//  PTOpenGLViewController.h
//  PhysicsTest
//
//Copyright (c) 2012 Erik M. Buck
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
