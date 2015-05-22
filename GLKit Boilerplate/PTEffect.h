//
//  PEffect.h
//  PhysicsTest
//

#import "UtilityEffect.h"
#import <GLKit/GLKMath.h>


@class GLKEffectPropertyTransform;
@class GLKEffectPropertyLight;

@interface PTEffect : UtilityEffect

@property (strong, nonatomic, readonly)
   GLKEffectPropertyTransform *transform;

@property (assign, nonatomic, readwrite) GLKVector4
   lightModelAmbientColor;

@property (strong, nonatomic, readonly)
   GLKEffectPropertyLight *light0;

@end
