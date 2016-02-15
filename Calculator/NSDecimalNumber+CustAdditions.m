//
//  NSDecimalNumber+CustAdditions.m
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

#import "NSDecimalNumber+CustAdditions.h"



@implementation NSDecimalNumber (CustAdditions)

BOOL forTanValue = NO;


-(NSDecimalNumber *)FixNumberforDecimalPlaces:(short)NoOfDigitsInDecimal{
    
    NSDecimalNumber *value = self;
    NSDecimalNumberHandler *num = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:NoOfDigitsInDecimal raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    value = [value decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"1"] withBehavior:num];
    return value;
}

-(NSDecimalNumber *)decimalNumberByRaisingToDecimalPower:(NSDecimalNumber *)power{
    
    NSDecimalNumber *num = power;
    NSDecimalNumber *pow = [NSDecimalNumber one];
    
    NSArray *dotSeparation = [[NSArray alloc]init];
    dotSeparation = [[power stringValue]componentsSeparatedByString:@"."];
    
    if (dotSeparation.count==1) {
    
        if ([num doubleValue]<0) {
            num = [num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        
        for (NSDecimalNumber *i=[NSDecimalNumber zero]; [i doubleValue]<[num doubleValue] ; i=[i decimalNumberByAdding:[NSDecimalNumber one]]) {
            pow = [pow decimalNumberByMultiplyingBy:self];
        }
        
        if ([power doubleValue]<0) {
            pow = [[ NSDecimalNumber one]decimalNumberByDividingBy:pow];
        }
        
        return pow;
        
    }else{
       
        NSDecimalNumber *selfNum = self;
        if ([self doubleValue]<0) {
            selfNum = [selfNum decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        NSDecimalNumber *pow = [[NSDecimalNumber alloc]init];
        
        if ([power doubleValue]<0) {
            num = [num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        
        pow = [num decimalNumberByMultiplyingBy:[selfNum naturalLogValue]];
        pow = [pow antilog];
        
        if ([power doubleValue]<0) {
            pow = [[ NSDecimalNumber one]decimalNumberByDividingBy:pow];
        }
        
        if ([self doubleValue]<0) {
            pow = [pow decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        
        return pow;
    }
    
}

-(NSDecimalNumber *)sinValue{
    
    NSDecimalNumber *sinVal = [NSDecimalNumber zero];
    int posNum=1;
    NSUInteger n = 6;
    if ([self doubleValue]>1 || [self doubleValue]<1) {
        n=30;
    }
    if ([self doubleValue]>4 || [self doubleValue ]<-4) {
        n=60;
    }
    if ([self doubleValue]<.1 && [self doubleValue]>-.1) {
        n=20;
    }
    if ([self doubleValue]<.01 && [self doubleValue]>-.01) {
        n=6;
    }
    if ([self doubleValue]<.000000000000001 && [self doubleValue]>-.000000000000001) {
        n=2;
    }
    for (NSDecimalNumber *x =[NSDecimalNumber decimalNumberWithString:@"1"]; [x integerValue]<n ; x=[x decimalNumberByAdding:[NSDecimalNumber one]]) {
        if ([x integerValue]%2 != 0) {
            if (posNum%2!=0) {
                sinVal = [sinVal decimalNumberByAdding:[[self decimalNumberByRaisingToPower:[x integerValue]]decimalNumberByDividingBy:[x factorial]]];
                posNum++;
            }else{
                sinVal = [sinVal decimalNumberBySubtracting:[[self decimalNumberByRaisingToPower:[x integerValue]]decimalNumberByDividingBy:[x factorial]]];
                posNum++;
            }
            
        }
        
    }

    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",sinVal];
    if (str.length>30) {
        [str replaceCharactersInRange:NSMakeRange(30,str.length-30) withString:@""];
    }
    if (([str isEqualToString:@"0.0000000000000000000000000000"] || [str isEqualToString:@"-0.000000000000000000000000000"])&& !forTanValue ) {
        sinVal = [NSDecimalNumber zero];
    }
    
    return sinVal;
    
}

-(NSDecimalNumber *)sinHyperBolicValue{
    NSDecimalNumber *sinhVal = [[NSDecimalNumber alloc]init];
    
    
    if ([self doubleValue]<295.9 && [self doubleValue]>-295.9) {
        
        if ([self doubleValue]<0) {
            NSDecimalNumber *num = [self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
            sinhVal = [[num antilog]decimalNumberBySubtracting:[[NSDecimalNumber one]decimalNumberByDividingBy:[num antilog]]];
            sinhVal = [sinhVal decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]];
            sinhVal = [sinhVal decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }else{
            sinhVal = [[self antilog]decimalNumberBySubtracting:[[NSDecimalNumber one]decimalNumberByDividingBy:[self antilog]]];
            sinhVal = [sinhVal decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]];
        }
        

    }
    else{
        @throw ([NSException exceptionWithName:@"NumTooBig" reason:@"sinh Value Exceeded Calcutable Limit" userInfo:nil]);
    }
    
    return sinhVal;
}


-(NSDecimalNumber *)sinInverseValue{
    
    NSDecimalNumber *coef =[NSDecimalNumber one] ,*sini = self;
    NSDecimalNumber *i,*num = sini;
    NSUInteger numer=1,denom=2;
    int n = 100;
   
    if ([self doubleValue]<1 && [self doubleValue]>-1) {
        n=120;
    }
    if ([self doubleValue]<.2 && [self doubleValue]>-.2 ) {
        n=30;
    }
    
    if ([self doubleValue]<1 && [self doubleValue]>-1) {
        
    for (i = [NSDecimalNumber decimalNumberWithString:@"3"]; [i integerValue] < n ; i = [i decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"2"]],numer+=2,denom+=2 ) {
        
        coef = [coef decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)numer]]];
        coef =[coef decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)denom]]];
        
        
        sini = [sini decimalNumberByAdding:[[[num decimalNumberByRaisingToPower:[i integerValue]]decimalNumberByDividingBy:i]decimalNumberByMultiplyingBy:coef]];
        
        
    }
    }else if([self doubleValue]==-1){
        sini = [NSDecimalNumber decimalNumberWithString:@"-1.57079632679489661923132169163975144205"];
    }else if([self doubleValue]==1){
        sini = [NSDecimalNumber decimalNumberWithString:@"1.57079632679489661923132169163975144205"];
    }else{
        @throw [NSException exceptionWithName:@"AngleOutofBounds" reason:@"Sin Inverse angle Out of Bounds" userInfo:nil];
    }
    
    return sini;
}


-(NSDecimalNumber *)sinHyperBolicInverseValue{
    
    NSDecimalNumber *coef =[NSDecimalNumber one] ,*sinhi = self;
    NSDecimalNumber *i,*num = sinhi;
    NSUInteger n=9,numer=1,denom=2,posNum=1;
    
    if ([self doubleValue]<100 && [self doubleValue]>-100) {
        n=15;
    }
    if ([self doubleValue]>1000000000 || [self doubleValue]<-1000000000) {
        n=5;
    }
    if ([self doubleValue]<1 && [self doubleValue]>-1) {
        
        for (i = [NSDecimalNumber decimalNumberWithString:@"3"]; [i integerValue] < 30 ; i = [i decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"2"]],numer+=2,denom+=2,posNum++ ) {
            
            coef = [coef decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)numer]]];
            coef =[coef decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)denom]]];
            
            if (posNum%2==0) {
                sinhi = [sinhi decimalNumberByAdding:[[[num decimalNumberByRaisingToPower:[i integerValue]]decimalNumberByDividingBy:i]decimalNumberByMultiplyingBy:coef]];
            }
            else{
                sinhi = [sinhi decimalNumberBySubtracting:[[[num decimalNumberByRaisingToPower:[i integerValue]]decimalNumberByDividingBy:i]decimalNumberByMultiplyingBy:coef]];
            }
            
            
        }
        
    }else{
        
        sinhi = [NSDecimalNumber zero];
        
        for (i = [NSDecimalNumber decimalNumberWithString:@"2"]; [i integerValue] < n ; i = [i decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"2"]],numer+=2,denom+=2,posNum++ ) {
            
            coef = [coef decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)numer]]];
            coef =[coef decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)denom]]];
            
            if (posNum%2!=0) {
                sinhi = [sinhi decimalNumberByAdding:[[[[NSDecimalNumber one]decimalNumberByDividingBy:[num decimalNumberByRaisingToPower:[i integerValue]]]decimalNumberByDividingBy:i]decimalNumberByMultiplyingBy:coef]];
            }
            else{
                sinhi = [sinhi decimalNumberBySubtracting:[[[[NSDecimalNumber one]decimalNumberByDividingBy:[num decimalNumberByRaisingToPower:[i integerValue]]]decimalNumberByDividingBy:i]decimalNumberByMultiplyingBy:coef]];
            }
            
            
        }
        
        NSDecimalNumber *num = self;
        
        if ([self doubleValue]<=-1) {
            num =[self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        
        sinhi = [sinhi decimalNumberByAdding:[[num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]]naturalLogValue]];
        
        if ([self doubleValue]<=-1) {
            sinhi = [sinhi decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        
    }
    
    
    return sinhi;
    
}



-(NSDecimalNumber *)cosValue{
    NSDecimalNumber *cosVal = [[NSDecimalNumber alloc]initWithString:@"0"];
    int posNum = 1;
    
    NSUInteger n = 6;
    
    if ([self doubleValue]>1 || [self doubleValue]<1) {
        n=40;
    }
    if ([self doubleValue]>4 || [self doubleValue ]<-4) {
        n=60;
    }
    if ([self doubleValue]<.1 && [self doubleValue]>-.1) {
        n=20;
    }
    if ([self doubleValue]<.01 && [self doubleValue]>-.01) {
        n=6;
    }
    if ([self doubleValue]<.000000000000001 && [self doubleValue]>-.000000000000001) {
        n=2;
    }
    @try {
        for (NSDecimalNumber *x =[NSDecimalNumber decimalNumberWithString:@"0"]; [x integerValue]<n ; x=[x decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"1"]]) {
            
            if ([x integerValue]%2 == 0) {
                if (posNum%2!=0) {
                    
                    cosVal = [cosVal decimalNumberByAdding:[[self decimalNumberByRaisingToPower:[x integerValue]]decimalNumberByDividingBy:[x factorial]]];
                    posNum++;
                }else{
                    cosVal = [cosVal decimalNumberBySubtracting:[[self decimalNumberByRaisingToPower:[x integerValue]]decimalNumberByDividingBy:[x factorial]]];
                    posNum++;
                }
                
            }
            
        }
        
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",cosVal];
    if (str.length>30) {
     [str replaceCharactersInRange:NSMakeRange(30,str.length-30) withString:@""];
    }
    if (([str isEqualToString:@"0.0000000000000000000000000000"] || [str isEqualToString:@"-0.000000000000000000000000000"]) &&!forTanValue ) {
        cosVal = [NSDecimalNumber zero];
    }

    return cosVal;
}

-(NSDecimalNumber *)cosHyperBolicValue{
    NSDecimalNumber *coshVal = [[NSDecimalNumber alloc]init];
    
    if ([self doubleValue]<295.9 && [self doubleValue]>-295.9) {
        
        NSDecimalNumber *num = self;
        if ([self doubleValue]<0) {
            num = [num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        coshVal = [[num antilog]decimalNumberByAdding:[[NSDecimalNumber one]decimalNumberByDividingBy:[num antilog]]];
        coshVal = [coshVal decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]];
        
    }
    else{
        @throw ([NSException exceptionWithName:@"NumTooBig" reason:@"sinh Value Exceeded Calcutable Limit" userInfo:nil]);
    }
    
    
    return coshVal;
}


-(NSDecimalNumber *)cosHyperBolicInverseValue{
    NSDecimalNumber *coef =[NSDecimalNumber one] ,*coshi;
    NSDecimalNumber *i,*num = self;
    NSUInteger n=4,numer=1,denom=2;
    
    if ([self doubleValue]<100) {
        n=30;
    }
    else if ([self doubleValue]<10000000000){
        n=6;
    }
    
    if ([self doubleValue]>1) {
        
        coshi = [NSDecimalNumber zero];
        
        for (i = [NSDecimalNumber decimalNumberWithString:@"2"]; [i integerValue] < n ; i = [i decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"2"]],numer+=2,denom+=2) {
            
            coef = [coef decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)numer]]];
            coef =[coef decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)denom]]];
            
            
            coshi = [coshi decimalNumberByAdding:[[[[NSDecimalNumber one]decimalNumberByDividingBy:[num decimalNumberByRaisingToPower:[i integerValue]]]decimalNumberByDividingBy:i]decimalNumberByMultiplyingBy:coef]];
            
        }
        
        coshi = [[[num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]]naturalLogValue]decimalNumberBySubtracting:coshi];
        
        if ([coshi doubleValue]<0) {
            coshi =[coshi decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        }
        
    }
    else if ([self doubleValue] == 1){
        coshi = [NSDecimalNumber zero];
    }
    else{
        @throw [NSException exceptionWithName:@"coshiOutofBounds" reason:@"The Value Entered out of Bounds" userInfo:nil];
    }
    return coshi;
    
}

-(NSDecimalNumber *)cosInverseValue{
    NSDecimalNumber *cosi = [[NSDecimalNumber decimalNumberWithString:@"1.57079632679489661923132169163975144205"] decimalNumberBySubtracting:[self sinInverseValue]];
    
    return cosi;
}



-(NSDecimalNumber *)tanValue{
    forTanValue=YES;
    
    NSDecimalNumber *tanVal = [[self sinValue]decimalNumberByDividingBy:[self cosValue]];
    forTanValue=NO;
    return tanVal;
}

-(NSDecimalNumber *)tanHyperBolicValue{
    
    NSDecimalNumber *tanhVal = [[NSDecimalNumber alloc]init];
    
    if ([self doubleValue]>25 ) {
        tanhVal = [NSDecimalNumber one];
    }
    else if([self doubleValue]<-25){
        tanhVal = [NSDecimalNumber decimalNumberWithString:@"-1"];
    }
    else{
        tanhVal = [[self sinHyperBolicValue]decimalNumberByDividingBy:[self cosHyperBolicValue]];
    }
    return tanhVal;
}


-(NSDecimalNumber *)tanInverseValue{
    NSDecimalNumber *tani = self;
    int posNum = 2;
    int n = 100;
    
    if ([tani doubleValue]<.13 && [tani doubleValue]>-.13) {
        n=25;
    }
    if ([tani doubleValue]<1 && [tani doubleValue]>-1) {
        
        for (NSUInteger i=3; i<n; i+=2,posNum++) {
            
            if (posNum%2!=0) {
                
                tani = [tani decimalNumberByAdding:[[self decimalNumberByRaisingToPower:i]decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)i]]]];
                
            }else{
                tani = [tani decimalNumberBySubtracting:[[self decimalNumberByRaisingToPower:i]decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)i]]]];
            }
            
        }
    }
    else{
        NSDecimalNumber *num;
        tani = [[NSDecimalNumber one] decimalNumberByDividingBy:tani];
        num = tani;
        tani = [tani decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        posNum=1;
        NSUInteger n=0;
        
        if ([self doubleValue]>99) {
            n=6;
        }
        else{
            n=30;
        }
        
        for (NSUInteger i=3; i<n; i+=2,posNum++) {
            
            if (posNum%2!=0) {
                tani=[tani decimalNumberByAdding:[[num decimalNumberByRaisingToPower:i] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)i]]]];
            }
            else{
                tani=[tani decimalNumberBySubtracting:[[num decimalNumberByRaisingToPower:i] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)i]]]];
            }
            
        }
        
        if ([self doubleValue]>1) {
            tani = [[NSDecimalNumber decimalNumberWithString:@"1.57079632679489661923132169163975144205"]decimalNumberByAdding:tani];
        }else if([self doubleValue]<-1){
            tani = [[NSDecimalNumber decimalNumberWithString:@"-1.57079632679489661923132169163975144205"]decimalNumberByAdding:tani];
        }
        
        if ([self doubleValue]==1) {
            tani=[NSDecimalNumber decimalNumberWithString:@"0.78539816339744830961566084581987572102"];
            
        }else if([self doubleValue]==-1){
            tani=[NSDecimalNumber decimalNumberWithString:@"-0.78539816339744830961566084581987572102"];
        }
        
        
    }
    
    return tani;
}

-(NSDecimalNumber *)tanHyperBolicInverseValue{
    NSDecimalNumber *tanhi = self;
    NSDecimalNumber *i;
    NSUInteger numer=1,denom=2;
    
    
    if ([self doubleValue]<1 && [self doubleValue]>-1) {
        
        for (i = [NSDecimalNumber decimalNumberWithString:@"3"]; [i integerValue] < 30 ; i = [i decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"2"]],numer+=2,denom+=2) {
            
            
            tanhi = [tanhi decimalNumberByAdding:[[self decimalNumberByRaisingToPower:[i integerValue]]decimalNumberByDividingBy:i]];
            
            
        }
        
    }
    return tanhi;
}

-(NSDecimalNumber *)log10Value{
    NSDecimalNumber *logVal = [[self naturalLogValue] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2.30258509299404568401799145"]];
    return logVal;
}

-(NSDecimalNumber *)naturalLogValue{
    NSDecimalNumber *elogVal = [[NSDecimalNumber alloc]initWithString:@"0"];
    
    @try {
        if ([self doubleValue]>0) {
            int z = 0;
            double i=1;
            NSUInteger n;
            n=70;
            NSDecimalNumber *num = self;
            
            if ([num doubleValue]>10) {
                for (z=1,i = 10 ; [num doubleValue] <= i || [num doubleValue]>i*10; i*=10,z++);
            }
            
            num = [num decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",i] ]];
            
            if ([num doubleValue]==1 || [num doubleValue]==10) {
                n=1000;
            }
            if ([num doubleValue] > 1 && [num doubleValue] <= 1.3 ) {
                n=10;
            }
            if ([num doubleValue]> 1.3 && [num doubleValue] <= 2.5) {
                n=40;
            }
            if ([num doubleValue]>2.5 && [num doubleValue] <= 4) {
                n=100;
            }
            if ([num doubleValue]>4 && [num doubleValue] <=5.5) {
                n=200;
            }
            if ([num doubleValue]>5.5 && [num doubleValue] <=7) {
                n=300;
            }
            if ([num doubleValue]>7 && [num doubleValue] <=9) {
                n=400;
            }
            if ([num doubleValue]>9 && [num doubleValue] <10) {
                n=500;
            }
            
            
            
            
            NSDecimalNumber *l1 =  [num decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"1"]];
            NSDecimalNumber *l2 =  [num decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"1"]];
            
            for (NSDecimalNumber *x =[NSDecimalNumber decimalNumberWithString:@"1"]; [x integerValue]<n; x=[x decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"1"]]) {
                
                if ([x integerValue]%2!=0) {
                    
                    elogVal = [elogVal decimalNumberByAdding:[[[l1 decimalNumberByDividingBy:l2]decimalNumberByRaisingToPower:[x integerValue]]decimalNumberByDividingBy:x]];
                }
                
                
            }
            
            elogVal = [elogVal decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]];
            
            elogVal = [elogVal decimalNumberByAdding:[[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",z]]decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2.30258509299404568401799145"]]];
            
            
        }
        else if ([self doubleValue]<=0){
            
            //            @throw([NSException raise:@"Negative or Zero Log Error:" format:@"Negative or Zero Log Error"]){
            //
            //            }
            
        }
        
        
    }
    @catch(NSException *e){
        @throw e;
    }
    
    
    
    
    return elogVal;
    
    
}

-(NSDecimalNumber *)antilog{
    
    NSDecimalNumber *eVal,*eDecVal = [NSDecimalNumber decimalNumberWithString:@"1"];
    @try {
        
        NSDecimalNumber *num = self;
        NSArray *dotSeparation = [[num stringValue]componentsSeparatedByString:@"."];
        NSDecimalNumber *num1=[NSDecimalNumber decimalNumberWithString:[dotSeparation objectAtIndex:0]];
        NSMutableString *s;
        NSDecimalNumber *num2;
        
        if (dotSeparation.count==2) {
            s =[NSMutableString stringWithString:[dotSeparation objectAtIndex:1]];
            [s insertString:@"." atIndex:0];
            num2 =[NSDecimalNumber decimalNumberWithString:s];
        }
        
        if ([num1 doubleValue]>=0) {
            eVal = [[NSDecimalNumber decimalNumberWithString:@"2.7182818284590452353602874713526620039"]decimalNumberByRaisingToPower:[num1 integerValue]];
        }else{
            num1 = [num1 decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
            eVal = [[NSDecimalNumber decimalNumberWithString:@"2.7182818284590452353602874713526620039"]decimalNumberByRaisingToPower:[num1 integerValue]];
            eVal = [[NSDecimalNumber one]decimalNumberByDividingBy:eVal];
        }
        
        
        if (dotSeparation.count==2) {
            
            
            
            for (NSDecimalNumber *x =[NSDecimalNumber decimalNumberWithString:@"1"]; [x integerValue]<20; x=[x decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"1"]]) {
                
                
                eDecVal=[eDecVal decimalNumberByAdding:[[num2 decimalNumberByRaisingToPower:[x integerValue]]decimalNumberByDividingBy:[x factorial]]];
                
            }
            eVal = [eVal decimalNumberByMultiplyingBy:eDecVal];
        }
        
    }
    @catch(NSException *e){
        
        @throw e;
        
    }
    return eVal;
}

-(NSDecimalNumber *)factorial{
    NSDecimalNumber *fact = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:0];
    for (NSUInteger i = [self integerValue]; i > 0; i--) {
        NSDecimalNumber *a = [NSDecimalNumber decimalNumberWithMantissa:i exponent:0 isNegative:0];
        fact = [fact decimalNumberByMultiplyingBy:a];
    }
    return fact;
}

-(NSDecimalNumber *)toRadian{
    NSDecimalNumber *radVal = [[self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"3.1415926535897932384626433832795028841"]]decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"180"]];
    
    return radVal;
}

-(NSDecimalNumber *)toDegree{
    NSDecimalNumber *degVal = [[self decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"3.1415926535897932384626433832795028841"]]decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"180"]];
    
    return degVal;
}

-(NSDecimalNumber *)decimalNumberByLeavingRemainderof:(NSDecimalNumber *)num{
    
    NSDecimalNumber *remainder = [self decimalNumberByDividingBy:num];
    remainder = [self decimalNumberBySubtracting:[[NSDecimalNumber decimalNumberWithString:[[[remainder stringValue] componentsSeparatedByString:@"."] objectAtIndex:0]] decimalNumberByMultiplyingBy:num]];
    return remainder;
    
}
@end
