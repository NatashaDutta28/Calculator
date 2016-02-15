//
//  Equation.h
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDecimalNumber+CustAdditions.h"

@interface Equation : NSObject

@property (strong, nonatomic) NSMutableArray* exp;
@property (strong, nonatomic) NSMutableArray* postExp;


- (NSDecimalNumber *) infixToPostfix : (NSString *) eq withAngle:(NSString *)ang;

+ (int) priority: (char) c;


@end
