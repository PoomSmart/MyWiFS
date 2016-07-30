#import <Foundation/Foundation.h>

static NSString *switchDomain = @"com.PS.MyWi.FS";
static NSString *currentTypeKey = @"PSMyWiCurrentInternetSharingType";

// WiFi, USB, Bluetooth
NSString *_currentType()
{
	CFStringRef r = (CFStringRef)CFPreferencesCopyAppValue((CFStringRef)currentTypeKey, (CFStringRef)switchDomain);
	return r ? (NSString *)r : @"WiFi";
}