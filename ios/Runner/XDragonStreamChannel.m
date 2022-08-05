//
//  XDragonStreamChannel.m
//  Runner
//
//  Created by xpeng on 2022/7/25.
//

#import "XDragonStreamChannel.h"
#import <Flutter/Flutter.h>
#import <streams_channel/StreamsChannelPlugin.h>


static XDragonStreamChannel *myself = nil;

@implementation XDragonStreamChannel
- (instancetype)init
{
    self = [super init];
    if (self) {
        myself = self;
    }
    return self;
}


+ (XDragonStreamChannel *)getMySelf {
    return myself;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar withName:(NSString *)name withDelegate: (id<StreamHandlerDelegate>)delegate {

  FlutterStreamsChannel *channel = [FlutterStreamsChannel streamsChannelWithName:name binaryMessenger:registrar.messenger];
  [channel setStreamHandlerFactory:^NSObject<FlutterStreamHandler> *(id arguments) {
    StreamHandler *_stream = [StreamHandler new];
      NSLog(@"myself======%@====%@====%@",myself,delegate,[self getMySelf]);
      _stream.delegate = delegate;
      return _stream;
  }];
}
- (void)onCancelWithArguments:(nonnull id)arguments {
    NSLog(@"events=======%@=======222=",arguments);

}

- (void)onListenWithArguments:(nonnull id)arguments eventSink:(nonnull FlutterEventSink)events {
    NSLog(@"events=======%@=======111=",events);

}

@end

@implementation StreamHandler

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    [self.delegate onListenWithArguments:arguments eventSink:events];
    
    if ([self.delegate respondsToSelector:@selector(onListenWithArguments:eventSink:)]) {
        NSLog(@"events=======%@======0000==",events);
       [self.delegate onListenWithArguments:arguments eventSink:events];
    }
   /// NSLog(@"events=======%@========",events);

    self.count = 1;
      self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if(self.count > 10) {
          events(FlutterEndOfEventStream);
        } else {
          events([NSString stringWithFormat:@"Hello %ld/10", (long)self.count]);
          self.count++;
        }
      }];
    
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    [self.timer invalidate];
    
    if([self.delegate respondsToSelector:@selector(onCancelWithArguments:)]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_delegate onCancelWithArguments:arguments];
        });
    }
  return nil;
}
@end
