#import <Flipswitch/FSSwitchSettingsViewController.h>
#import <Flipswitch/FSSwitchPanel.h>
#import <UIKit/UIKit.h>
#import <notify.h>
#import "Common.h"

__attribute__((visibility("hidden")))
@interface MyWiFSSettingsViewController : UITableViewController <FSSwitchSettingsViewController> {
@private
	NSString *type;
}
@end

@implementation MyWiFSSettingsViewController

- (id)init
{
	if ((self = [super initWithStyle:UITableViewStyleGrouped]))
		type = _currentType();
	return self;
}

- (NSArray *)supportedTypes
{
	return @[ @"WiFi", @"USB", @"Bluetooth" ];
}

- (NSUInteger)indexForKey:(NSString *)key
{
	return [[self supportedTypes] indexOfObject:key];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)table
{
	return 1;
}

- (NSString *)tableView:(UITableView *)table titleForHeaderInSection:(NSInteger)section
{
	return @"Desired Switch Type";
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ?: [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] autorelease];
	cell.textLabel.text = [self supportedTypes][indexPath.row];
	cell.accessoryType = ([self indexForKey:type] == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSInteger row = indexPath.row;
	[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self indexForKey:type] inSection:indexPath.section]].accessoryType = UITableViewCellAccessoryNone;
	type = [self supportedTypes][row];
	CFPreferencesSetAppValue((CFStringRef)currentTypeKey, (CFTypeRef)type, (CFStringRef)switchDomain);
	CFPreferencesAppSynchronize((CFStringRef)switchDomain);
	notify_post([switchDomain UTF8String]);
	[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

@end