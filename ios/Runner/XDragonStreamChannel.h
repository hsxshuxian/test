//
//  XDragonStreamChannel.h
//  Runner
//
//  Created by xpeng on 2022/7/25.
//


#import <Foundation/Foundation.h>
#import <streams_channel/FlutterStreamsChannel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol StreamHandlerDelegate <NSObject>
-(void) onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events;
-(void) onCancelWithArguments:(id)arguments;
@end

@interface StreamHandler : NSObject<FlutterStreamHandler>
@property(nonatomic,weak) id<StreamHandlerDelegate> delegate;
@property(strong, nonatomic) NSTimer *timer;
@property(assign, nonatomic) NSInteger count;

@end

@interface XDragonStreamChannel : NSObject

+ (XDragonStreamChannel *)getMySelf;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar withName:(NSString *)name withDelegate: (id<StreamHandlerDelegate>)delegate;


@end
NS_ASSUME_NONNULL_END
