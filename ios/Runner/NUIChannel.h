
#import <Foundation/Foundation.h>
#import "XpChannel.h"
#import "XDragonStreamChannel.h"
#import <streams_channel/FlutterStreamsChannel.h>
NS_ASSUME_NONNULL_BEGIN

@interface NUIChannel : NSObject<XpChannel, StreamHandlerDelegate>
+ (NUIChannel *)getMySelf;

@end

NS_ASSUME_NONNULL_END
