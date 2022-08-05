//
//  HsxChannel.m
//  Runner
//
//  Created by xpeng on 2022/7/26.
//

#import "HsxChannel.h"
static HsxChannel *myself = nil;
@interface HsxChannel()
@property(nonatomic, weak) FlutterEventSink eventSink;

@end
@implementation HsxChannel
@synthesize name;

+ (HsxChannel *)getMySelf {
    return myself;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        name = @"channelName2";
        myself = self;
    }
    return self;
}
- (void)receive:(NSString *)method withParams:(id)params withResult:(FlutterResult)result {
    result(@"ggggggg==========测试成功==");
}

@end
