//
//  TickTock.m
//  TickTock
//
//  Created by Daniel Larsson on 03/10/2016.
//  Copyright © 2016 daniellarsson. All rights reserved.
//

#import "TickTock.h"

@interface TickTock ()

@property (nonatomic) NSMutableDictionary *activeOperations;

@end

@implementation TickTock

+ (TickTock *)sharedTickTock
{
    static dispatch_once_t once;

    static TickTock *sharedTickTock;

    dispatch_once(&once, ^{ sharedTickTock = [[TickTock alloc] init]; });

    return sharedTickTock;
}

+ (void)tick:(NSString *)operation
{
    // Operation began
    if (operation)
        [[[self sharedTickTock] activeOperations] setObject:[NSDate date] forKey:operation];
}

+ (void)tock:(NSString *)operation
{
    // Operation has finished
    NSDate *startTime = [[[self sharedTickTock] activeOperations] objectForKey:operation];
    if (startTime)
    {
        double timePassed = -[startTime timeIntervalSinceNow] * 1000;
        NSLog(@"%@ finished in %f ms", operation, timePassed);
    }
    else
    {
        NSLog(@"%@ was never started", operation);
    }
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.activeOperations = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
