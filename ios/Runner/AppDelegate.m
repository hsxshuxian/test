#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "XpChannel.h"
#import "NUIChannel.h"
#import "HsxChannel.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

    [self registerChannel: [[HsxChannel alloc] init]];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)registerChannel:(NSObject<XpChannel>*)registry {
    FlutterViewController *controller = (FlutterViewController *)[[self window] rootViewController];
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:registry.name binaryMessenger:controller.binaryMessenger];
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        [registry receive:call.method withParams:call.arguments withResult: result];
    }];
}

@end
