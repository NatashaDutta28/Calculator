//
//  Equation.m
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

#import "Equation.h"


@implementation Equation

@synthesize exp;
@synthesize postExp;

- (instancetype) init
{
    self = [super init];
    exp = [[NSMutableArray alloc] init];
    postExp = [[NSMutableArray alloc] init];
    return self;
}


enum operator {plus=65, minus, mul, divi, rais, nCr, nPr, factorial, sine, cosine, tangent, sinInv, cosInv, tanInv, hypSin, hypCos, hypTan,hypInvSin,hypInvCos,hypInvTan, lOG10, lOGe, bo = '(', bc = ')'};


- (NSDecimalNumber *) infixToPostfix:(NSString *)eq withAngle:(NSString *)ang
{
    
    //Pre-Evaluation
    
    NSUInteger lBracCount=0,rBracCount=0;
    
    do{
        if ([eq componentsSeparatedByString:@"("]!=nil) {
            lBracCount = [[eq componentsSeparatedByString:@"("] count]-1;
        }
        if ([eq componentsSeparatedByString:@")"]!=nil) {
             rBracCount = [[eq componentsSeparatedByString:@")"] count]-1;
        }
       
        if (lBracCount>rBracCount) {
            eq = [eq stringByAppendingString:@")"];
        }
        
    }while (lBracCount>rBracCount);
    
    
    do{
        lBracCount = [[eq componentsSeparatedByString:@"("] count]-1;
        rBracCount = [[eq componentsSeparatedByString:@")"] count]-1;
        
        if (rBracCount>lBracCount) {
            
            lBracCount=rBracCount=0;
            
                for (int i = 0; i<eq.length; i++) {
                    
                    
                    if ([eq characterAtIndex:i]=='(') {
                        lBracCount++;
                    }
                    if ([eq characterAtIndex:i]==')') {
                        rBracCount++;
                    }
                    if ([eq characterAtIndex:i]==')' && rBracCount>lBracCount) {
                        eq = [eq stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@""];
                        rBracCount--;
                    }
                
                }
            
        }
    }while (rBracCount>lBracCount);
    
    
    rBracCount = lBracCount=0;
    
    eq = [eq stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    eq = [eq stringByReplacingOccurrencesOfString:@"x" withString:@"*"];
    eq = [eq stringByReplacingOccurrencesOfString:@" " withString:@""];
    

    for (int i = 0; i < eq.length-1; i++) {
        
        if ([eq characterAtIndex:i]=='c'
            ||
            [eq characterAtIndex:i]=='s'
            ||
            [eq characterAtIndex:i]=='t') {
            
            if ([eq characterAtIndex:i]=='c') {
                eq=[eq stringByReplacingCharactersInRange:NSMakeRange(i+2, 1) withString:@"z"];
            }
            
            if ([eq characterAtIndex:i+3]!='h' && [eq characterAtIndex:i+3]!='i') {
                eq=[eq stringByReplacingCharactersInRange:NSMakeRange(i+2, 1) withString:@"x"];
            }
            
            if ([eq characterAtIndex:i+3]=='h' && [eq characterAtIndex:i+4]=='i') {
                eq=[eq stringByReplacingCharactersInRange:NSMakeRange(i+3, 1) withString:@"b"];
            }
            
            if ([eq characterAtIndex:i+1]=='i') {
                eq=[eq stringByReplacingCharactersInRange:NSMakeRange(i+1, 1) withString:@"o"];
            }
        }
        
        if ([eq characterAtIndex:i]=='l' && [eq characterAtIndex:i+1]=='n') {
            eq = [eq stringByReplacingCharactersInRange:NSMakeRange(i+1, 1) withString:@"g"];
        }
        
        
        if ([eq characterAtIndex:i]=='.' && !isnumber([eq characterAtIndex:i+1])) {
            eq = [eq stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@""];
            i--;
        }
        
    }
    
    for (int i = 0; i < eq.length-1; i++) {
        
        if (([eq characterAtIndex:i]=='e' || [eq characterAtIndex:i]=='E') && ([eq characterAtIndex:i+1]!='+'&&[eq characterAtIndex:i+1]!='*'&&[eq characterAtIndex:i+1]!='/'&&[eq characterAtIndex:i+1]!='^'&&[eq characterAtIndex:i+1]!='C'&&[eq characterAtIndex:i+1]!='P' &&[eq characterAtIndex:i+1]!='!' &&[eq characterAtIndex:i+1]!='%')) {
            NSMutableString *str = [NSMutableString stringWithString:eq];
            [str insertString:@"^" atIndex:i+1];
            eq = [NSString stringWithString:str];
            i++;
        }
    }

    
    eq = [self multiplicationAfterCharacter:'/' inString:eq];
    eq = [self multiplicationAfterCharacter:'h' inString:eq];
    eq = [self multiplicationAfterCharacter:'g' inString:eq];
    eq = [self multiplicationAfterCharacter:'x' inString:eq];
    eq = [self multiplicationAfterCharacter:'i' inString:eq];
    eq = [self multiplicationAfterCharacter:'^' inString:eq];
    
    for (NSUInteger i=0;i < eq.length-1;i++) {
        NSMutableString * s = [NSMutableString stringWithString:eq];
        if ((isnumber([eq characterAtIndex:i])) &&
            (!isnumber([eq characterAtIndex:i+1]) &&
             ([eq characterAtIndex:i+1]!='+') &&
             ([eq characterAtIndex:i+1]!='-') &&
             ([eq characterAtIndex:i+1]!='*') &&
             ([eq characterAtIndex:i+1]!='/') &&
             ([eq characterAtIndex:i+1]!='^') &&
             ([eq characterAtIndex:i+1]!='C') &&
             ([eq characterAtIndex:i+1]!='P') &&
             ([eq characterAtIndex:i+1]!=')') &&
             ([eq characterAtIndex:i+1]!='.') &&
             ([eq characterAtIndex:i+1]!='!') &&
             ([eq characterAtIndex:i+1]!='%')
             )){
                
                [s insertString:@"*" atIndex:i+1];
                eq = [NSString stringWithString:s];
                
            }

        if (([eq characterAtIndex:i]==')') && (
                                               [eq characterAtIndex:i+1]!='+'&&
                                               [eq characterAtIndex:i+1]!='-' &&
                                               [eq characterAtIndex:i+1]!='*' &&
                                               [eq characterAtIndex:i+1]!='/' &&
                                               [eq characterAtIndex:i+1]!='^' &&
                                               [eq characterAtIndex:i+1]!=')' &&
                                               [eq characterAtIndex:i+1]!='%')) {
            
            [s insertString:@"*" atIndex:i+1];
            eq=[NSString stringWithString:s];
        }
        
    }
    
    NSMutableString *strTemp = [NSMutableString stringWithString: eq];
    
    
    for (NSUInteger i=0;i < eq.length-1;i++) {
        
        if ((([[[strTemp stringByReplacingCharactersInRange:NSMakeRange(0, i) withString:@""] stringByReplacingCharactersInRange:NSMakeRange(1, strTemp.length-i-1) withString:@""]isEqualToString:@"∏"]
             )||( [eq characterAtIndex:i]=='%') || [eq characterAtIndex:i]=='!') &&
            ((isnumber([eq characterAtIndex:i+1]) || [[[strTemp stringByReplacingCharactersInRange:NSMakeRange(0, i+1) withString:@""] stringByReplacingCharactersInRange:NSMakeRange(1, strTemp.length-(i+1)-1) withString:@""]isEqualToString:@"∏"]
              || [eq characterAtIndex:i+1]=='e'
              || [eq characterAtIndex:i+1]=='E'
              || [eq characterAtIndex:i+1]=='('))){
            
            
            [strTemp insertString:@"*" atIndex:i+1];
            eq = [NSString stringWithString:strTemp];
            
        }
        
    }
    
    for (int i=0; i<eq.length; i++) {
        
        if ([eq characterAtIndex:i]=='%') {
            int percPos=i;
            BOOL charWasBrac=NO;
            NSString *percStr = [eq stringByReplacingCharactersInRange:NSMakeRange(i,eq.length-i) withString:@""];
            lBracCount=rBracCount=0;
            int x;
            
            for (x=i-1; rBracCount>=lBracCount && x>=-1; x--) {
                
                if ([percStr characterAtIndex:x]==')') {
                    rBracCount++;
                }
                else if ([percStr characterAtIndex:x]=='('){
                    lBracCount++;
                }
            }
            if ([percStr characterAtIndex:x+1]=='(') {
                charWasBrac=YES;
            }
            percStr = [percStr stringByReplacingCharactersInRange:NSMakeRange(0, x+2) withString:@""];
            
            if (x<1) {
                x=-1;
                if (charWasBrac) {
                    i-=2;
                }else{
                    i--;
                }
                
            }else{
            i-=x+3;
            }
            int j;
            for (j=i; j>0; j--) {
                
                if ([percStr characterAtIndex:j]=='+') {
                
                    
                    NSDecimalNumber *part1 = [self infixToPostfix:[percStr stringByReplacingCharactersInRange:NSMakeRange(j, i-j+1) withString:@""] withAngle:ang];
                    
                    NSDecimalNumber *part2 = [self infixToPostfix:[percStr stringByReplacingCharactersInRange:NSMakeRange(0, j+1) withString:@""] withAngle:ang];
                    
                    part2 = [[part1 decimalNumberByMultiplyingBy:part2]decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100" ]];
                    part1 = [part1 decimalNumberByAdding:part2];
                    
                    if (x<1) {
                        eq = [eq stringByReplacingCharactersInRange:NSMakeRange(0, percPos+1) withString:[part1 stringValue]];
                    }
                    else{
                    eq = [eq stringByReplacingCharactersInRange:NSMakeRange(x+1, percStr.length+2) withString:[part1 stringValue]];
                    }
                    NSDecimalNumber *ans = [self infixToPostfix:eq withAngle:ang];
                    return ans;
                }
                else if ([percStr characterAtIndex:j]=='-') {
                
                    
                    NSDecimalNumber *part1 = [self infixToPostfix:[percStr stringByReplacingCharactersInRange:NSMakeRange(j, i-j+1) withString:@""] withAngle:ang];
                    
                    NSDecimalNumber *part2 = [self infixToPostfix:[percStr stringByReplacingCharactersInRange:NSMakeRange(0, j+1) withString:@""] withAngle:ang];
                    
                    part2 = [[part1 decimalNumberByMultiplyingBy:part2]decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100" ]];
                    part1 = [part1 decimalNumberBySubtracting:part2];
                    
                    if (x<1) {
                        eq = [eq stringByReplacingCharactersInRange:NSMakeRange(0, percPos+1) withString:[part1 stringValue]];
                    }
                    else{
                        eq = [eq stringByReplacingCharactersInRange:NSMakeRange(x+1, percStr.length+2) withString:[part1 stringValue]];
                    }
                    NSDecimalNumber *ans = [self infixToPostfix:eq withAngle:ang];
                    return ans;
                }
                else if ([percStr characterAtIndex:j]=='*' || [percStr characterAtIndex:j]==')' || [percStr characterAtIndex:j]=='/'){
                    eq = [eq stringByReplacingCharactersInRange:NSMakeRange(percPos, 1) withString:@"*0.01"];
                    NSDecimalNumber *ans = [self infixToPostfix:eq withAngle:ang];
                    return ans;

                }
             
            }
            
            if (j==0) {
                eq = [eq stringByReplacingCharactersInRange:NSMakeRange(percPos, 1) withString:@"*0.01"];
            }
            
        }
        
    }
    
    eq = [eq stringByReplacingOccurrencesOfString:@"∏" withString:@"3.1415926535897932384626433832795028841"];
    eq = [eq stringByReplacingOccurrencesOfString:@"e" withString:@"2.7182818284590452353602874713526620039"];
    eq = [eq stringByReplacingOccurrencesOfString:@"E" withString:@"10"];
    
    //Initializing Infix Expression
    NSUInteger len = [eq length];
    unichar c;
    NSDecimalNumber *num = [NSDecimalNumber zero];
    bool flag = 0, f = 0, min = 0;
    int cn = 1;
    enum operator op = plus;
    [exp addObject:[NSString stringWithFormat:@"("]];
    for (int i = 0; i < len; i++) {
        c = [eq characterAtIndex:i];
        if (!(isalnum(c) || c == '.')) {
            if (flag) {
                if (min) {
                    num = [num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
                }
                [exp addObject:num];
                flag = f = min = 0;
                num = [NSDecimalNumber zero];
            }
            switch (c) {
                case '+':
                    op = plus;
                    break;
                    
                case '-':
                    if (isdigit([eq characterAtIndex:i-1])
                        ||
                        [eq characterAtIndex:i-1]==')'||[eq characterAtIndex:i-1]=='!') {
                        op = minus;
                    }
                    else {
                        min = 1;
                        continue;
                    }
                    break;
                    
                case '*':
                    op = mul;
                    break;
                    
                case '/':
                    op = divi;
                    break;
                    
                case '^':
                    op = rais;
                    break;
                    
                case '!':
                    op = factorial;
                    break;
                    
                case '(':
                    op = bo;
                    break;
                    
                case ')':
                    op = bc;
                    break;
                    
            }
            NSString *temp = [NSString stringWithFormat:@"%c", op];
            [exp addObject:temp];
        }
        else if(isalpha(c)) {
            if (flag) {
                if (min) {
                    num = [num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
                }
                [exp addObject:num];
                flag = f = min = 0;
                num = [NSDecimalNumber zero];
                
            }
            switch (c) {
                case 's':
                    if ([eq characterAtIndex:i+3]=='i') {
                        op = sinInv;
                        i++;
                    }
                    else if ([eq characterAtIndex:i+3] == 'h') {
                        op = hypSin;
                        i++;
                    }
                    else if ([eq characterAtIndex:i+3] == 'b' &&
                             [eq characterAtIndex:i+4]=='i') {
                        op = hypInvSin;
                        i+=2;
                    }
                    else {
                        op = sine;
                    }
                    break;
                    
                case 'c':
                    
                    if ([eq characterAtIndex:i+3]=='i') {
                        op = cosInv;
                        i++;
                    }
                    else if ([eq characterAtIndex:i+3] == 'h') {
                        
                        op = hypCos;
                        i++;
                        
                    }
                    
                    else if ([eq characterAtIndex:i+3] == 'b' &&
                             [eq characterAtIndex:i+4]=='i') {
                        op = hypInvCos;
                        i+=2;
                    }
                    else {
                        op = cosine;
                    }
                    break;
                    
                case 't':
                    if ([eq characterAtIndex:i+3]=='i') {
                        op = tanInv;
                        i++;
                    }
                    else if ([eq characterAtIndex:i+3]=='h') {
                        
                        op = hypTan;
                        i++;
                        
                        
                    }
                    else if ([eq characterAtIndex:i+3] == 'b' &&
                             [eq characterAtIndex:i+4]=='i') {
                        op = hypInvTan;
                        i+=2;
                    }
                    else {
                        op = tangent;
                    }
                    break;
                    
                case 'l':
                    if ([eq characterAtIndex:i+1] == 'o') {
                        op = lOG10;
                    }
                    else if ([eq characterAtIndex:i+1] == 'g') {
                        op = lOGe;
                        i--;
                    }
                    break;
                    
                case 'C':
                    op = nCr;
                    i-=2;
                    break;
                    
                case 'P':
                    op = nPr;
                    i-=2;
                    break;
                    
            }
            NSString *temp = [NSString stringWithFormat:@"%c", op];
            [exp addObject:temp];
            i+=2;
        }
        else {
            flag = 1;
            if (c == '.') {
                f = 1;
                cn = 1;
                continue;
            }
            short int b = (int) c - (int) '0';
            NSDecimalNumber *d = [NSDecimalNumber decimalNumberWithMantissa:b exponent:0 isNegative:0];
            if (f) {
                num = [num decimalNumberByAdding:[d decimalNumberByMultiplyingByPowerOf10:-cn]];
                //number = number + b * pow(0.1, cn);
                cn++;
            }
            else {
                num = [num decimalNumberByMultiplyingByPowerOf10:1];
                num = [num decimalNumberByAdding:d];
                //number = number*10 + b;
            }
            
            if (i == len-1) {
                if (min) {
                    num = [num decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
                }
                [exp addObject:num];
                flag = f = min = 0;
                num = [NSDecimalNumber zero];
            }
        }
    }
    [exp addObject:[NSString stringWithFormat:@")"]];
    
    //Converting Infix To Postfix
    id obj;
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    len = [exp count];
    for (obj in exp) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [postExp addObject:obj];
        }
        else {
            if (![stack count] || [obj characterAtIndex:0] == '(') {
                [stack addObject:obj];
            }
            else if ([obj characterAtIndex:0] == ')') {
                while ([[stack lastObject] characterAtIndex:0] != '(') {
                    [postExp addObject:[stack lastObject]];
                    [stack removeLastObject];
                }
                [stack removeLastObject];
            }
            else if ([Equation priority:[obj characterAtIndex:0]] < [Equation priority:[[stack lastObject] characterAtIndex:0]] || ( [Equation isBinary:[obj characterAtIndex:0]] && [Equation isBinary:[obj characterAtIndex:0]] && ([Equation priority:[obj characterAtIndex:0]] == [Equation priority:[[stack lastObject] characterAtIndex:0]]))) {
                while ([Equation priority:[obj characterAtIndex:0]] <= [Equation priority:[[stack lastObject] characterAtIndex:0]]) {
                    [postExp addObject:[stack lastObject]];
                    [stack removeLastObject];
                }
                [stack addObject:obj];
            }
            else {
                [stack addObject:obj];
            }
        }
    }
    
    //Equating Postfix Expression
    
    len = [postExp count];
    
    for (obj in postExp) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [stack addObject:obj];
        }
        else {
            char c = [obj characterAtIndex:0];
            op = c;
            if ([Equation isBinary: op])  {
                int n,r;
                NSDecimalNumber *temp2 = [[NSDecimalNumber alloc] init];
                temp2  = [stack lastObject];
                [stack removeLastObject];
                NSDecimalNumber *temp1 = [[NSDecimalNumber alloc] init];
                temp1 = [stack lastObject];
                [stack removeLastObject];
                switch (op){
                    case factorial:
                    case sine:
                    case cosine:
                    case tangent:
                    case hypSin:
                    case hypCos:
                    case hypTan:
                    case hypInvSin:
                    case hypInvCos:
                    case hypInvTan:
                    case sinInv:
                    case cosInv:
                    case tanInv:
                    case lOG10:
                    case lOGe:
                    case bo:
                    case bc:
                        break;
                        
                    case nCr:
                        n = [temp1 intValue];
                        r = [temp2 intValue];
                        if (r<=n) {
                            
                            temp1 = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:0];
                            for (int i = n ; i >  n-r; i--) {
                                NSDecimalNumber *a = [NSDecimalNumber decimalNumberWithMantissa:i exponent:0 isNegative:0];
                                temp1 = [temp1 decimalNumberByMultiplyingBy:a];
                            }
                            for (int i = r ; i > 0; i--) {
                                NSDecimalNumber *a = [NSDecimalNumber decimalNumberWithMantissa:i exponent:0 isNegative:0];
                                temp1 = [temp1 decimalNumberByDividingBy:a];
                            }
                            
                        }else{
                            @throw ([NSException exceptionWithName:@"rGreaterThanN" reason:@"The Value of r for nCr Exceeds Value of n" userInfo:nil]);
                        }
                        
                        break;
                        
                    case nPr:
                        n = [temp1 intValue];
                        r = [temp2 intValue];
                        
                        if (r<=n) {
                            
                            temp1 = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:0];
                            for (int i = n ; i > n-r ; i--) {
                                NSDecimalNumber *a = [NSDecimalNumber decimalNumberWithMantissa:i exponent:0 isNegative:0];
                                temp1 = [temp1 decimalNumberByMultiplyingBy:a];
                            }
                            
                        }else{
                            @throw ([NSException exceptionWithName:@"rGreaterThanN" reason:@"The Value of r for nPr Exceeds Value of n" userInfo:nil]);
                        }
                        break;
                        
                    case plus:
                        temp1 = [temp1 decimalNumberByAdding:temp2];
                        break;
                        
                    case minus:
                        temp1 = [temp1 decimalNumberBySubtracting:temp2];
                        break;
                        
                    case mul:
                        temp1 = [temp1 decimalNumberByMultiplyingBy:temp2];
                        break;
                        
                    case divi:
                        temp1 = [temp1 decimalNumberByDividingBy:temp2];
                        break;
                        
                    case rais:
                        temp1 =  [temp1 decimalNumberByRaisingToDecimalPower:temp2];
                        break;
                }
                [stack addObject:temp1];
            }
            else {
                NSDecimalNumber *temp = [stack lastObject];
                [stack removeLastObject];
                switch (op) {
                    case sine:
                        if ([ang isEqualToString: @"Deg"]) {
                            if ([temp doubleValue]>360 || [temp doubleValue]<-360) {
                                temp = [temp decimalNumberByLeavingRemainderof:[NSDecimalNumber decimalNumberWithString:@"360"]];
                            }
                            
                            temp = [[temp toRadian] sinValue];
                            break;
                            
                        }else {
                            temp = [temp decimalNumberByLeavingRemainderof:[NSDecimalNumber decimalNumberWithString:@"6.2831853071795864769252867665590057682"]];
                            temp = [temp sinValue];
                            break;
                        }
                    case cosine:
                        if ([ang isEqualToString: @"Deg"]) {
                            if ([temp doubleValue]>360 || [temp doubleValue]<-360) {
                                temp = [temp decimalNumberByLeavingRemainderof:[NSDecimalNumber decimalNumberWithString:@"360"]];
                            }
                            temp = [[temp toRadian] cosValue];
                            break;
                            
                        }else {
                            temp = [temp decimalNumberByLeavingRemainderof:[NSDecimalNumber decimalNumberWithString:@"6.2831853071795864769252867665590057682"]];
                            temp = [temp cosValue];
                            break;
                        }
                        
                    case tangent:
                        if ([ang isEqualToString: @"Deg"]) {
                            if ([temp doubleValue]>360 || [temp doubleValue]<-360) {
                                temp = [temp decimalNumberByLeavingRemainderof:[NSDecimalNumber decimalNumberWithString:@"360"]];
                            }
                            if ([temp doubleValue] == 90 || [temp doubleValue]== 270) {
                                @throw [NSException exceptionWithName:@"plusInfinity" reason:@"tan 90 = infinity" userInfo:nil];
                            }else if([temp doubleValue] == -90 || [temp doubleValue]== -270){
                                @throw [NSException exceptionWithName:@"minusInfinity" reason:@"tan -90 = -infinity" userInfo:nil];
                            }
                            temp = [[temp toRadian] tanValue];
                            break;
                            
                        }else {
                            temp =[temp decimalNumberByLeavingRemainderof:[NSDecimalNumber decimalNumberWithString:@"6.2831853071795864769252867665590057682"]];
                            temp = [temp tanValue];
                            break;
                        }
                        
                    case factorial:
                        if ([temp doubleValue]>-1 && [temp doubleValue]<102) {
                            temp = [temp factorial];
                        }
                        else if([temp doubleValue]<0){
                            @throw ([NSException exceptionWithName:@"NegativeFact" reason:@"The Factorial can't Be Found for Negative Number" userInfo:nil]);
                        }
                        else{
                            @throw ([NSException exceptionWithName:@"NumTooBig" reason:@"The Factorial can't Be Found for Num Greater Than 102" userInfo:nil]);
                        }
                        break;
                        
                        
                    case sinInv:
                        temp = [temp sinInverseValue];
                        
                        if ([ang isEqualToString:@"Deg"]) {
                            
                            temp = [temp toDegree];
                        }
                        
                        break;
                        
                    case cosInv:
                        temp = [temp cosInverseValue];
                        
                        if ([ang isEqualToString:@"Deg"]) {
                            
                            temp = [temp toDegree];
                        }
                        
                        break;
                        
                    case tanInv:
                        temp = [temp tanInverseValue];
                        
                        if ([ang isEqualToString:@"Deg"]) {
                            
                            temp = [temp toDegree];
                        }
                        
                        break;
                        
                    case hypSin:
                        temp = [temp sinHyperBolicValue];
                        break;
                        
                    case hypCos:
                        temp = [temp cosHyperBolicValue];
                        break;
                        
                    case hypTan:
                        temp = [temp tanHyperBolicValue];
                        break;
                        
                    case hypInvSin:
                        temp = [temp sinHyperBolicInverseValue];
                        break;
                    case hypInvCos:
                        temp = [temp cosHyperBolicInverseValue];
                        break;
                    case hypInvTan:
                        if ([temp doubleValue] >= 1 || [temp doubleValue] <= -1) {
                            @throw [NSException exceptionWithName:@"tanHypInvError" reason:@"Value Greater or Eqaul to 1 or -1" userInfo:nil];
                        }
                        temp = [temp tanHyperBolicInverseValue];
                        break;
                        
                    case lOG10:
                        temp = [temp log10Value];
                        break;
                        
                    case lOGe:
                        temp = [temp naturalLogValue];
                        break;
                        
                        
                    case plus:
                    case minus:
                    case mul:
                    case divi:
                    case rais:
                    case nCr:
                    case nPr:
                    case bo:
                    case bc:
                        break;
                        
                }
                NSString *s = [NSString stringWithFormat:@"%@", temp];
                num = [NSDecimalNumber decimalNumberWithString:s];
                [stack addObject:num];
            }
        }
    }
    return [stack lastObject];
}

-(NSString *)multiplicationAfterCharacter:(char)c inString:(NSString *)eq{
    
    NSUInteger lBracCount = 0,rBracCount=0,bracketOpened=0;
    for (int j=0; j<eq.length; j++) {
        
        
        for (NSUInteger i=j;i < eq.length;i++) {
            
            
            if ([eq characterAtIndex:i]==c && [eq characterAtIndex:i+1]!='(') {
                
                NSMutableString * s = [NSMutableString stringWithString:eq];
                [s insertString:@"(" atIndex:i+1];
                eq = [NSString stringWithString:s];
                i++;
                bracketOpened++;
                
                
            }else if (bracketOpened>0) {
                
                if ([eq characterAtIndex:i]=='+' ||
                    [eq characterAtIndex:i]=='*' ||
                    [eq characterAtIndex:i]=='/' ||
                    ((isnumber([eq characterAtIndex:i-1])||[eq characterAtIndex:i-1]=='e'||[eq characterAtIndex:i-1]=='E')&&[eq characterAtIndex:i]=='-')||
                    [eq characterAtIndex:i]==')' ||
                    [eq characterAtIndex:i]=='(' ){
                    
                    if ([eq characterAtIndex:i]=='(') {
                        lBracCount++;
                        
                        while (lBracCount-rBracCount!=0) {
                            
                            
                            i++;
                            if ([eq characterAtIndex:i]=='(') {
                                lBracCount++;
                            }
                            if ([eq characterAtIndex:i]==')') {
                                rBracCount++;
                            }
                            
                        }
                        NSMutableString * s = [NSMutableString stringWithString:eq];
                        [s insertString:@")" atIndex:i+1];
                        eq = [NSString stringWithString:s];
                        
                        bracketOpened--;
                        
                    }else{
                        NSMutableString * s = [NSMutableString stringWithString:eq];
                        [s insertString:@")" atIndex:i];
                        eq = [NSString stringWithString:s];
                        
                        bracketOpened--;
                    }
                }else if (i==eq.length-1){
                    
                    NSMutableString * s = [NSMutableString stringWithString:eq];
                    [s insertString:@")" atIndex:i+1];
                    eq = [NSString stringWithString:s];
                    bracketOpened--;
                }
            }
        }
    }
    return eq;
}


+ (BOOL) isBinary: (int) a
{
    if  (a <= nPr)
        return 1;
    else
        return 0;
}

+ (int) priority: (char) c
{
    enum operator op = c;
    switch (op)
    {
        case factorial: return 6;
        case nCr:
        case nPr:
        case rais: return 5;
        case lOG10:
        case lOGe:
        case hypInvSin:
        case hypInvCos:
        case hypInvTan:
        case sinInv:
        case cosInv:
        case tanInv:
        case hypSin:
        case hypCos:
        case hypTan:
        case sine :
        case cosine :
        case tangent : return 4;
        case mul :
        case divi : return 2;
        case plus :
        case minus : return 1;
        default  : return 0;
    }
}

@end

