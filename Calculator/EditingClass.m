//
//  EditingClass.m
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

#import "EditingClass.h"
#import "NSDecimalNumber+CustAdditions.h"

@implementation EditingClass


+(NSString*)deleteLastValueFromEquation:(NSString*)text{
    
    NSMutableString *newText = [[NSMutableString alloc]initWithString:text];
    
    if ([newText characterAtIndex:newText.length-1]=='i' && [newText characterAtIndex:newText.length-2]=='h'){
        
        [newText deleteCharactersInRange:NSMakeRange(newText.length-4, 4)];
    }
    else if([newText characterAtIndex:newText.length-1]=='i' || [newText characterAtIndex:newText.length-1]=='h'){

        [newText deleteCharactersInRange:NSMakeRange(newText.length-3, 3)];
    }
    else if (([newText characterAtIndex:newText.length-1]=='n' && [newText characterAtIndex:newText.length-2]=='i')||
             ([newText characterAtIndex:newText.length-1]=='n' && [newText characterAtIndex:newText.length-2]=='a') ||
             [newText characterAtIndex:newText.length-1]=='s'||
             [newText characterAtIndex:newText.length-1]=='g'||
             [newText characterAtIndex:newText.length-1]==' ') {
        
        [newText deleteCharactersInRange:NSMakeRange(newText.length-2, 2)];
        
    }else if([newText characterAtIndex:newText.length-1]=='n' && [newText characterAtIndex:newText.length-2]=='l'){
        
        [newText deleteCharactersInRange:NSMakeRange(newText.length-1, 1)];
    }
    
    [newText deleteCharactersInRange:NSMakeRange(newText.length-1, 1)];
    
    return newText;
}




+ (NSString*)calculateAnswerForEquation:(NSString*)text{
    
    NSString *angle = @"Deg";
    
    @try {
        
        Equation *eq = [[Equation alloc]init];
        NSMutableString *t = [NSMutableString stringWithString:text];
        
//        if( (text.length==1)||(( (text.length==4 && ([text characterAtIndex:2]=='n'))
//                                 ||((text.length==4 && ([text characterAtIndex:2]=='s'))||((text.length==4 && ([text characterAtIndex:2]=='g'))))))){
//            t = [NSMutableString stringWithString:@""];
//        }
        
        while (t.length!=0 && !isnumber([t characterAtIndex:t.length-1]) ) {

            if (t.length>=5 && [t characterAtIndex:t.length-1]=='i' && [t characterAtIndex:t.length-2]=='h') {
                
                [t replaceCharactersInRange:NSMakeRange(t.length-5, 5) withString:@""];
                
            }
            
            else if (t.length>=4. && ([t characterAtIndex:t.length-1]=='h' || [t characterAtIndex:t.length-1]=='i')) {
                
                [t replaceCharactersInRange:NSMakeRange(t.length-4, 4) withString:@""];
                
            }
            else if (t.length>=3 && ((([t characterAtIndex:t.length-1]=='n') && ([t characterAtIndex:t.length-2]=='i' || [t characterAtIndex:t.length-2]=='a'))||
                                     [t characterAtIndex:t.length-1]=='s' ||
                                     [t characterAtIndex:t.length-1]=='g' ||
                                     [t characterAtIndex:t.length-1]==' '
                                     )){
                
                [t replaceCharactersInRange:NSMakeRange(t.length-3, 3) withString:@""];
                
            }
            else if((t.length>=2 && [t characterAtIndex:t.length-1]=='n' && [t characterAtIndex:t.length-2]=='l')){
                
                [t replaceCharactersInRange:NSMakeRange(t.length-2, 2) withString:@""];
                
            }
            else if (t.length>=1 && ([t characterAtIndex:t.length-1]=='.' ||
                                     [t characterAtIndex:t.length-1]=='C' ||
                                     [t characterAtIndex:t.length-1]=='P' ||
                                     [t characterAtIndex:t.length-1]=='(' ||
                                     [t characterAtIndex:t.length-1]==')' ||
                                     [t characterAtIndex:t.length-1]=='-' ||
                                     [t characterAtIndex:t.length-1]=='^'
                                     )){
                
                [t replaceCharactersInRange:NSMakeRange(t.length-1, 1) withString:@""];
                
            }
            
            else if (t.length>=1 && ([[[NSMutableString stringWithString:t]stringByReplacingCharactersInRange:NSMakeRange(0, t.length-1) withString:@""]isEqualToString:@"∏"]  ||
                                     [[[NSMutableString stringWithString:t ]stringByReplacingCharactersInRange:NSMakeRange(0, t.length-1) withString:@""]isEqualToString:@"%"]
                                     ||
                                     [t characterAtIndex:t.length-1]=='e'
                                     || [t characterAtIndex:t.length-1]=='!'
                                     || [t characterAtIndex:t.length-1]=='E')){
                
                break;
            }
        }
        
        if (t.length!=0) {
            
            NSDecimalNumber *ans = [eq infixToPostfix:t withAngle:angle];
            
            NSArray *dotSeparation = [[NSString stringWithFormat:@"%@",ans] componentsSeparatedByString:@"." ];
            int zeroCount=0;
            
            @try{
                if (dotSeparation.count>1) {
                    
                    if([[dotSeparation objectAtIndex:0]characterAtIndex:0]=='0' || ([[dotSeparation objectAtIndex:0]characterAtIndex:0]=='-' && [[dotSeparation objectAtIndex:0]characterAtIndex:1]=='0')){
                        for (zeroCount=0; [[dotSeparation objectAtIndex:1] characterAtIndex:zeroCount]=='0'; zeroCount++);
                    }
                }
                
            }@catch(NSException *e){
                @throw e;
            }
            @finally{
                NSMutableString *ansString,*ansStringCopy;
                
                dotSeparation = [[NSString stringWithFormat:@"%@",ans] componentsSeparatedByString:@"." ];
                
                if ([[dotSeparation objectAtIndex:0] length]>15) {
                    
                    ansString = [NSMutableString stringWithString:[[NSMutableString stringWithFormat:@"%@",ans] stringByReplacingOccurrencesOfString:@"." withString:@""]];
                    
                    if ([ansString characterAtIndex:0]=='-') {
                        [ansString insertString:@"." atIndex:2];
                    }else{
                        [ansString insertString:@"." atIndex:1];
                    }
                    
                    ansStringCopy=ansString;
                    
                    ans = [NSDecimalNumber decimalNumberWithString:ansString];
                    
                    
                    ansString = [NSMutableString stringWithFormat: @"%@",ans];
                    if ([ansString characterAtIndex:0]=='-') {
                        [ansString appendString:[NSString stringWithFormat:@" E%llu",(unsigned long long)ansStringCopy.length-3]];
                    }else{
                        [ansString appendString:[NSString stringWithFormat:@" E%llu",(unsigned long long)ansStringCopy.length-2]];
                    }
                }
                else if(([[dotSeparation objectAtIndex:0]characterAtIndex:0]=='0' || ([[dotSeparation objectAtIndex:0]characterAtIndex:0]=='-' && [[dotSeparation objectAtIndex:0]characterAtIndex:1]=='0')) && zeroCount>1){
                    
                    ans = [eq infixToPostfix:t withAngle:angle];
                    ansStringCopy = [NSMutableString stringWithString:[ans stringValue]];
                    dotSeparation = [[NSString stringWithFormat:@"%@",ans] componentsSeparatedByString:@"." ];
                    
                    ansString = [NSMutableString stringWithString:[[dotSeparation objectAtIndex:1] stringByReplacingCharactersInRange:NSMakeRange(0, zeroCount) withString:@"" ]];
                    if ([ansStringCopy characterAtIndex:0]=='-') {
                        [ansString insertString:@"." atIndex:1];
                    }
                    else{
                        [ansString insertString:@"." atIndex:1];
                    }
                    
                    ans = [NSDecimalNumber decimalNumberWithString:ansString];
                    
                    ansString = [NSMutableString stringWithFormat: @"%@",ans];
                    
                    if ([ansStringCopy characterAtIndex:0]=='-') {
                        [ansString insertString:@"-" atIndex:0];
                        [ansString appendString:[NSString stringWithFormat:@" E-%llu",(unsigned long long)zeroCount+1]];
                    }else{
                        [ansString appendString:[NSString stringWithFormat:@" E-%llu",(unsigned long long)zeroCount+1]];
                    }
                }else{
                    
                    NSString *tempString = [dotSeparation objectAtIndex:0];
                    ansString = [NSMutableString stringWithString:tempString];
                    NSUInteger x=ansString.length;
                    
                    for (NSInteger j = x-3; j>0; j-=3) {
                        if ([ansString characterAtIndex:j-1]!='-') {
                            [ansString insertString:@"," atIndex:j];
                        }
                        
                    }
                    if (dotSeparation.count==2) {
                        [ansString appendString:@"."];
                        [ansString appendString:[dotSeparation objectAtIndex:1]];
                    }
                    
                    
                }
                
                return ansString;
            }
        }
    }
    
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.name);
        
        if ([exception.name isEqualToString:@"NSDecimalNumberOverflowException"]|| [exception.name isEqualToString:@"NSDecimalNumber overflow exception"] || [exception.name isEqualToString:@"NumTooBig"]){
            
            return @"Answer Too Long";
            
        }else if([exception.name isEqualToString:@"NSRangeException"]||[exception.name isEqualToString:@"NSDecimalNumberUnderflowException"]) {
            
            return @"Answer Out of Bounds";
            
        }else if ([exception.name isEqualToString: @"NSDecimalNumberDivideByZeroException"]|| [exception.name isEqualToString:@"plusInfinity"]) {
            return @"∞";
        }
        else if ([exception.name isEqualToString:@"minusInfinity"]){
            
            return @"-∞";
        }
        else if([exception.name isEqualToString:@"NegativeFact"]){
            
             return @"Negative Factorial is Absurd";
        }
        else if([exception.name isEqualToString:@"rGreaterThanN"]){
            return @"Error! ('r' Greater Than 'n')";
        }
        else if([exception.name isEqualToString:@"AngleOutofBounds"]||[exception.name isEqualToString:@"coshiOutofBounds"]|| [exception.name isEqualToString:@"tanHypInvError"]){
            return @"Value Out of Bounds";
        }
    }
    @finally {
     
        
        
    }
    
    return  nil;
    
}


@end
