//
//  MyCustomModule.h
//  devcircle2
//
//  Created by Anh Tuan Nguyen on 2/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

/**
 * Basic native module without support emit event, we just need NSObject<RCTBridgeModule>
 * othercase we need RCTEventEmitter<RCTBridgeModule>
 */
@interface MyCustomModule: RCTEventEmitter<RCTBridgeModule>

@end
