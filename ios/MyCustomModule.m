//
//  MyCustomModule.m
//  devcircle2
//
//  Created by Anh Tuan Nguyen on 2/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "MyCustomModule.h"

@implementation MyCustomModule

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(hello:
                  (NSString *)name
                  callback:(RCTResponseSenderBlock) callback) {
  NSString *helloString = [NSString stringWithFormat:@"Hi %@, Welcome to native world", name];
  callback(@[helloString]);
}

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

RCT_EXPORT_METHOD(pingPong:
                  (BOOL *)signalHere
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
  @try {
    NSNumber *val = signalHere ? @YES : @NO;
    NSLog(@"value input is: %@", val);
    if([val integerValue] == 0) {
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
@end
