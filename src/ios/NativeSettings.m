#import "NativeSettings.h"

@implementation NativeSettings

- (void)openWithScheme:(NSString *)pref andWithCallbackLocation:(CDVInvokedUrlCommand*)command {
	if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
		void (^respondToSettingsSuccess)(BOOL success);
		respondToSettingsSuccess = ^(BOOL success) {
			CDVPluginResult* pluginResult = nil;

			if (success) {
				pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[pref stringByAppendingString:@" : Opened with openURL:options:completionHandler: method"]];
			} else {
				pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[pref stringByAppendingString:@" : Cannot open with openURL:options:completionHandler: method"]];
			}

			[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		};

		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:pref] options:@{} completionHandler:respondToSettingsSuccess];
	} else {
		CDVPluginResult* pluginResult = nil;

		if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:pref]]) {
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[pref stringByAppendingString:@" : Opened with openURL method"]];
		} else {
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[pref stringByAppendingString:@" : Cannot open with openURL method"]];
		}

		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}
}

- (void)open:(CDVInvokedUrlCommand*)command
{
	NSString* key = [command.arguments objectAtIndex:0];
	NSString* schemeString = @"";
	NSString* schemeSpecifics = @"";
	
	if ([key isEqualToString:@"application_details"]) {
		schemeString = UIApplicationOpenSettingsURLString;
	} else {
		if ([[[UIDevice currentDevice] systemVersion] intValue] < 10) {
			schemeString = @"prefs:";
		} else {
			schemeString = @"App-Prefs:";
		}

		if ([key isEqualToString:@"settings"]) {
			//Nothing needs to be added to string.
		} else if ([key isEqualToString:@"about"]) {
			schemeSpecifics = @"root=General&path=About";
		} else if ([key isEqualToString:@"accessibility"]) {
			schemeSpecifics = @"root=General&path=ACCESSIBILITY";
		} else if ([key isEqualToString:@"account"]) {
			schemeSpecifics = @"root=ACCOUNT_SETTINGS";
		} else if ([key isEqualToString:@"airplane_mode"]) {
			schemeSpecifics = @"root=AIRPLANE_MODE";
		} else if ([key isEqualToString:@"autolock"]) {
			schemeSpecifics = @"root=General&path=AUTOLOCK";
		} else if ([key isEqualToString:@"display"]) {
			schemeSpecifics = @"root=Brightness";
		} else if ([key isEqualToString:@"bluetooth"]) {
			schemeSpecifics = @"root=Bluetooth";
		} else if ([key isEqualToString:@"castle"]) {
			schemeSpecifics = @"root=CASTLE";
		} else if ([key isEqualToString:@"cellular_usage"]) {
			schemeSpecifics = @"root=General&path=USAGE/CELLULAR_USAGE";
		} else if ([key isEqualToString:@"configuration_list"]) {
			schemeSpecifics = @"root=General&path=ManagedConfigurationList";
		} else if ([key isEqualToString:@"date"]) {
			schemeSpecifics = @"root=General&path=DATE_AND_TIME";
		} else if ([key isEqualToString:@"facetime"]) {
			schemeSpecifics = @"root=FACETIME";
		} else if ([key isEqualToString:@"settings"]) {
			schemeSpecifics = @"root=General";
		} else if ([key isEqualToString:@"tethering"]) {
			schemeSpecifics = @"root=INTERNET_TETHERING";
		} else if ([key isEqualToString:@"music"]) {
			schemeSpecifics = @"root=MUSIC";
		} else if ([key isEqualToString:@"music_equalizer"]) {
			schemeSpecifics = @"root=MUSIC&path=EQ";
		} else if ([key isEqualToString:@"music_volume"]) {
			schemeSpecifics = @"root=MUSIC&path=VolumeLimit";
		} else if ([key isEqualToString:@"keyboard"]) {
			schemeSpecifics = @"root=General&path=Keyboard";
		} else if ([key isEqualToString:@"locale"]) {
			schemeSpecifics = @"root=General&path=INTERNATIONAL";
		} else if ([key isEqualToString:@"location"]) {
			schemeSpecifics = @"root=LOCATION_SERVICES";
		} else if ([key isEqualToString:@"network"]) {
			schemeSpecifics = @"root=General&path=Network";
		} else if ([key isEqualToString:@"nike_ipod"]) {
			schemeSpecifics = @"root=NIKE_PLUS_IPOD";
		} else if ([key isEqualToString:@"notes"]) {
			schemeSpecifics = @"root=NOTES";
		} else if ([key isEqualToString:@"notification_id"]) {
			schemeSpecifics = @"root=NOTIFICATIONS_ID";
		} else if ([key isEqualToString:@"passbook"]) {
			schemeSpecifics = @"root=PASSBOOK";
		} else if ([key isEqualToString:@"phone"]) {
			schemeSpecifics = @"root=Phone";
		} else if ([key isEqualToString:@"photos"]) {
			schemeSpecifics = @"root=Photos";
		} else if ([key isEqualToString:@"reset"]) {
			schemeSpecifics = @"root=General&path=Reset";
		} else if ([key isEqualToString:@"ringtone"]) {
			schemeSpecifics = @"root=Sounds&path=Ringtone";
		} else if ([key isEqualToString:@"browser"]) {
			schemeSpecifics = @"root=Safari";
		} else if ([key isEqualToString:@"search"]) {
			schemeSpecifics = @"root=General&path=Assistant";
		} else if ([key isEqualToString:@"sound"]) {
			schemeSpecifics = @"root=Sounds";
		} else if ([key isEqualToString:@"software_update"]) {
			schemeSpecifics = @"root=General&path=SOFTWARE_UPDATE_LINK";
		} else if ([key isEqualToString:@"storage"]) {
			schemeSpecifics = @"root=CASTLE&path=STORAGE_AND_BACKUP";
		} else if ([key isEqualToString:@"store"]) {
			schemeSpecifics = @"root=STORE";
		} else if ([key isEqualToString:@"usage"]) {
			schemeSpecifics = @"root=General&path=USAGE";
		} else if ([key isEqualToString:@"video"]) {
			schemeSpecifics = @"root=VIDEO";
		} else if ([key isEqualToString:@"vpn"]) {
			schemeSpecifics = @"root=General&path=Network/VPN";
		} else if ([key isEqualToString:@"wallpaper"]) {
			schemeSpecifics = @"root=Wallpaper";
		} else if ([key isEqualToString:@"wifi"]) {
			schemeSpecifics = @"root=WIFI";
		} else {
			CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid Action"];
			[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
			return;
		}
	
		schemeString = [schemeString stringByAppendingString:schemeSpecifics];
	}

	[self openWithScheme:schemeString andWithCallbackLocation:command];
}

@end
