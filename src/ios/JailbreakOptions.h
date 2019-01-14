//
//  JailbreakOptions.h
//
//  Created by TCG Digital on 14/01/19.
//  Copyright © 2019 TCG Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
@interface JailbreakOptions : CDVPlugin
- (void)isJailbrokenDevice:(CDVInvokedUrlCommand*)command;
@end
