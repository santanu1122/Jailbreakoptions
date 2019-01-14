//
//  JailbreakOptions.m
//
//  Created by TCG Digital on 14/01/19.
//  Copyright © 2019 TCG Digital. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "JailbreakOptions.h"

@implementation JailbreakOptions

- (void)isJailbrokenDevice:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    if ([self isJailbrokenDevice]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Not An Apple Authorised Device"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Apple Authorised Device"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (BOOL)isJailbrokenDevice {
    
#if !(TARGET_IPHONE_SIMULATOR)
    
    FILE *file = fopen("/Applications/Cydia.app", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/bin/bash", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/usr/sbin/sshd", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/etc/apt", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/usr/bin/ssh", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:@"/Applications/Cydia.app"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/bin/bash"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/sbin/sshd"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/etc/apt"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/bin/ssh"]) {
        return YES;
    }
    
    // Check if the app can access outside of its sandbox
    NSError *error = nil;
    NSString *string = @".";
    [string writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        [fileManager removeItemAtPath:@"/private/jailbreak.txt" error:nil];
        return YES;
    }
    
    // Check if the app can open a Cydia's URL scheme
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        return YES;
    }
#endif
    return NO;
}
@end
