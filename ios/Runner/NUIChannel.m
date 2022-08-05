
#import "NUIChannel.h"
static NUIChannel *myself = nil;
@interface NUIChannel()
@property(nonatomic, weak) FlutterEventSink eventSink;

@end
@implementation NUIChannel
@synthesize name;

+ (NUIChannel *)getMySelf {
    return myself;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        name = @"channelName";
        myself = self;
    }
    return self;
}
- (void)receive:(NSString *)method withParams:(id)params withResult:(FlutterResult)result {
    result(@"ggggggg==========测试成功==");
}

@end
