#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import <dlfcn.h>
#import "Common.h"
#import "MyWiHeader.h"

@interface BluetoothManager : NSObject
+ (instancetype)sharedInstance;
@end

@interface MyWiFSSwitch : NSObject <FSSwitchDataSource>
@end

@implementation MyWiFSSwitch

- (MyWiSettings *)myWi
{
	return [NSClassFromString(@"MyWiSettings") sharedInstance];
}

- (NSString *)currentType
{
	return _currentType();
}

- (BOOL)toggleEnabled
{
	NSString *key = [self currentType];
	return [([self myWi].settings)[key][@"Enabled"] boolValue];
}

- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier
{
	return [NSString stringWithFormat:@"MyWi %@", [self currentType]];
}

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return [self toggleEnabled] ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	NSDictionary *settings = [self myWi].settings;
	NSDictionary *newSettings = [NSClassFromString(@"MyWiSettings") dictionary:settings setValue:[NSNumber numberWithBool:newState == FSSwitchStateOn] forKeyPath:[NSArray arrayWithObjects:[self currentType], @"Enabled", nil]];
    [self myWi].settings = newSettings;
    [[self myWi] settingsChanged];
}

@end

%ctor
{
	dlopen("/Applications/MyWi.app/MyWiCommon.dylib", RTLD_LAZY);
	dlopen("/Applications/MyWi.app/MyWiCore.dylib", RTLD_LAZY);
	[BluetoothManager sharedInstance];
}