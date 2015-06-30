//
//  NSString+HKRC4.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/30.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "NSString+HKRC4.h"

@implementation NSString (HKRC4)

- (NSString*)cryptByRC4WithKey:(NSString*)key;
{
    int j = 0;
    unichar res[self.length];
    const unichar* buffer = res;
    unsigned char s[256];
    for (int i = 0; i < 256; i++)
    {
        s[i] = i;
    }
    for (int i = 0; i < 256; i++)
    {
        j = (j + s[i] + [key characterAtIndex:(i % key.length)]) % 256;
        
        char c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
    
    int i = j = 0;
    
    for (int y = 0; y < self.length; y++)
    {
        i = (i + 1) % 256;
        j = (j + s[i]) % 256;
        
        char c = s[i];
        s[i] = s[j];
        s[j] = c;
        
        unsigned char f = [self characterAtIndex:y] ^ s[ (s[i] + s[j]) % 256];
        res[y] = f;
    }
    return [NSString stringWithCharacters:buffer length:self.length];
}

@end
