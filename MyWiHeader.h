#import <Foundation/Foundation.h>

@interface MyWiSettings : NSObject
+ (instancetype)sharedInstance;
+ (NSDictionary *)dictionary:(NSDictionary *)dictionary setValue:(id)value forKeyPath:(NSArray *)keyPath;
@property(retain, nonatomic) NSDictionary *settings;
@end