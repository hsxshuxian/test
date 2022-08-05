
#ifndef XpChannel_h
#define XpChannel_h

#import <Flutter/Flutter.h>

@protocol XpChannel <NSObject>

- (void)receive:(NSString *)method withParams:(id)params withResult:(FlutterResult)result;

@required
@property NSString* name;

@end


#endif /* XpChannel_h */
