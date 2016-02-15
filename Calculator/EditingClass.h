//
//  EditingClass.h
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Equation.h"

@interface EditingClass : NSObject

+ (NSString*)calculateAnswerForEquation:(NSString*)text;
+ (NSString*)deleteLastValueFromEquation:(NSString*)text;
        
@end
