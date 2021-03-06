//
//  WeexPluginLoader.m
//  BaalDemo
//
//  Created by dianwoda on 2017/12/30.
//  Copyright © 2017年 dianwoda. All rights reserved.
//

#import "WeexPluginLoader.h"
#import "WeexPluginConfigParser.h"
@interface WeexPluginLoader ()
@property (nonatomic, readwrite, strong) NSXMLParser* configParser;
@property (nonatomic, readwrite, strong) NSArray *pluginNames;
@property (nonatomic, readwrite, strong) NSDictionary* settings;
@end
@implementation WeexPluginLoader
@synthesize configParser;
+ (NSArray *)getPlugins
{
    WeexPluginConfigParser *delegate = [[WeexPluginConfigParser alloc] init];
    [self parseSettingsWithParser:delegate];
    return [NSArray arrayWithArray:delegate.pluginNames] ?: nil;
}
+ (void)parseSettingsWithParser:(NSObject <NSXMLParserDelegate>*)delegate
{
    // read from config.xml in the app bundle
    NSString* path = [self configFilePath:@"WeexpluginConfig.xml"];
    
    NSURL* url = [NSURL fileURLWithPath:path];
    
    NSXMLParser *configParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    if (configParser == nil) {
        NSLog(@"Failed to initialize XML parser.");
        return;
    }
    [configParser setDelegate:((id < NSXMLParserDelegate >)delegate)];
    [configParser parse];
}

+(NSString*)configFilePath:(NSString *)configPath
{
    NSString* path = configPath ?: @"config.xml";
    // if path is relative, resolve it against the main bundle
    if(![path isAbsolutePath]){
        NSString* absolutePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        if(!absolutePath){
            NSAssert(NO, @"ERROR: %@ not found in the main bundle!", path);
        }
        path = absolutePath;
    }
    // Assert file exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSAssert(NO, @"ERROR: %@ does not exist. Please run weexpack-ios/bin/weexpack_plist_to_config_xml path/to/project.", path);
        return nil;
    }
    
    return path;
}
@end

