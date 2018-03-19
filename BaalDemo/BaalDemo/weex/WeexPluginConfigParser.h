//
//  WeexPluginConfigParser.h
//  fojiasanbao
//
//  Created by dianwoda on 2017/12/30.
//  Copyright © 2017年 fojiasanbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeexPluginConfigParser : NSObject <NSXMLParserDelegate>
{
    NSString* featureName;
}
@property (nonatomic, readonly, strong) NSMutableDictionary* pluginsDict;
@property (nonatomic, readonly, strong) NSMutableDictionary* settings;
@property (nonatomic, readonly, strong) NSMutableArray* pluginNames;
@end

