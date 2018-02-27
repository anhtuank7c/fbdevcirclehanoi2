//
//  MyCustomModule.m
//  devcircle2
//
//  Created by Anh Tuan Nguyen on 2/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "MyCustomModule.h"
#import <React/RCTConvert.h>

@implementation MyCustomModule {
  BOOL hasListeners;
}

RCT_EXPORT_MODULE();

#pragma mark - hello

RCT_EXPORT_METHOD(hello:
                  (NSString *)name
                  callback:(RCTResponseSenderBlock) callback) {
  NSString *helloString = [NSString stringWithFormat:@"Hi %@, Welcome to native world", name];
  callback(@[helloString]);
}

#pragma mark - personInfo

RCT_EXPORT_METHOD(personInfo:
                  (NSString *)firstname
                  lastname:(NSString *)lastname
                  age:(nonnull NSNumber *)age
                  salary:(nonnull NSNumber *)salary
                  gender:(BOOL *) gender
                  array:(NSArray *)array
                  object:(NSDictionary *)object
                  callback:(RCTResponseSenderBlock)callback) {
  NSObject *date = @{@"Mon": @2, @"Tue": @3, @"Sat": @7};
  NSArray *options = @[@"One", @"Two", @"Three", date];
  NSDictionary *data = @{@"firstname": firstname, @"lastname": lastname, @"age": age, @"salary": salary, @"gender": gender ? @YES : @NO, @"options": options, @"object": object, @"array": array};
  callback(@[data]);
}

#pragma mark - pingPong

// you guys can use RCT_EXPORT_METHOD, or RCT_REMAP_METHOD
// RCT_EXPORT_METHOD: bridge modules can also define methods that are exported to JavaScript as NativeModules.ModuleName.methodName
// RCT_REMAP_METHOD: similar to RCT_EXPORT_METHOD, but it sets the method name which is exported to the JS.

//RCT_EXPORT_METHOD(pingPong:
//                 (BOOL *)signalHere
//                 delay:(nonnull NSNumber *)delay
//                 resolve:(RCTPromiseResolveBlock)resolve
//                 reject:(RCTPromiseRejectBlock)reject) {

RCT_REMAP_METHOD(pingPong,
                  signalHere:(BOOL *)signalHere
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    @try {
      if(signalHere == NO) {
        @throw [NSException exceptionWithName:@"SignalException" reason:@"Signal is false" userInfo:nil];
      }
      NSDictionary *data = @{@"signal": @"Signal is true"};
      resolve(data);
    }@catch(NSException *exception) {
      NSMutableDictionary *info = [NSMutableDictionary dictionary];
      [info setValue:exception.name forKey:@"ExceptionName"];
      [info setValue:exception.reason forKey:@"ExceptionReason"];
      [info setValue:exception.callStackReturnAddresses forKey:@"ExceptionCallStackReturnAddresses"];
      [info setValue:exception.callStackSymbols forKey:@"ExceptionCallStackSymbols"];
      [info setValue:exception.userInfo forKey:@"ExceptionUserInfo"];
      
      NSError *error = [[NSError alloc] initWithDomain:@"com.example.myApp" code:4 userInfo:info];
      reject([info valueForKey:@"ExceptionName"], [info valueForKey:@"ExceptionReason"], error);
    }
}

// override function to do something in case you want to use event emitter
- (void)startObserving {
  hasListeners = YES;
}

// override function to do something in case you want to use event emitter
- (void)stopObserving {
  hasListeners = NO;
}

/**
 * register event name
 * NOTE: Note that using events gives us no guarantees about execution time, as the event is handled on a separate thread
 * Events are powerful, because they allow us to change React Native components without needing a reference to them
 */
- (NSArray<NSString *> *)supportedEvents {
  return @[@"addEvent"];
}

#pragma mark - addEvent
// I export this method to demo that native call js method via event
// In fact, you will using event to process something like: update video progress etc...
RCT_REMAP_METHOD(addEvent,
                 name:(NSString *)name
                 details:(NSDictionary *)details)
{
  if(hasListeners) {
    NSString *location = [RCTConvert NSString:details[@"location"]];
    NSString *time = [RCTConvert NSString:details[@"time"]];
    [self sendEventWithName:@"addEvent" body:@{@"name": name, @"location": location, @"time": time}];
  } else {
    NSLog(@"You did not registered any event/listener");
  }
}

@end
