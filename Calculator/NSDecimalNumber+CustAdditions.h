//
//  NSDecimalNumber+CustAdditions.h
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (CustAdditions)

-(NSDecimalNumber *)FixNumberforDecimalPlaces:(short)NoOfDigitsInDecimal;
-(NSDecimalNumber *)decimalNumberByRaisingToDecimalPower:(NSDecimalNumber *)power;
-(NSDecimalNumber *)sinValue;
-(NSDecimalNumber *)sinHyperBolicValue;
-(NSDecimalNumber *)sinInverseValue;
-(NSDecimalNumber *)sinHyperBolicInverseValue;
-(NSDecimalNumber *)cosValue;
-(NSDecimalNumber *)cosHyperBolicValue;
-(NSDecimalNumber *)cosInverseValue;
-(NSDecimalNumber *)cosHyperBolicInverseValue;
-(NSDecimalNumber *)log10Value;
-(NSDecimalNumber *)tanValue;
-(NSDecimalNumber *)tanHyperBolicValue;
-(NSDecimalNumber *)tanInverseValue;
-(NSDecimalNumber *)tanHyperBolicInverseValue;
-(NSDecimalNumber *)toRadian;
-(NSDecimalNumber *)toDegree;
-(NSDecimalNumber *)factorial;
-(NSDecimalNumber *)naturalLogValue;
-(NSDecimalNumber *)antilog;
-(NSDecimalNumber *)decimalNumberByLeavingRemainderof:(NSDecimalNumber *)num;
@end
