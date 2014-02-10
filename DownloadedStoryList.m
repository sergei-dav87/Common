//
//  DownloadedStoryList.m
//  Vipavo
//
//  Created by admin on 12/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownloadedStoryList.h"
#import "Global.h"

@implementation SimpleStoryInfo

@synthesize m_strStoryName, m_strThumbnailUrl, m_strStoryNameWithDate;
@synthesize m_nVersion, m_nPageCount;

- (id) initWithDictionary:(NSDictionary*)dic {
    [self init];
    m_strStoryName = [[NSString alloc] initWithString:[dic objectForKey:keyStoryName]];
    m_strStoryNameWithDate = [[NSString alloc] initWithString:[dic objectForKey:keyStoryNameWithDate]];
    m_strThumbnailUrl = [[NSString alloc] initWithString:[dic objectForKey:keyStoryThumbnail]];
    m_nVersion = [[dic objectForKey:keyVersion] intValue];
    m_nPageCount = [[dic objectForKey:keyPageCount] intValue];
    return self;
}

- (void) dealloc {
    [m_strStoryName release];
    [m_strStoryNameWithDate release];
    [m_strThumbnailUrl release];
    [super dealloc];
}

@end
@implementation DownloadedStoryList

@synthesize m_arrayStoryList;

- (id) initWithUrl:(NSString*)strUrl {
    [self init];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:strUrl]];
    NSArray* array = [dic objectForKey:keyStoryList];
    m_arrayStoryList = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i ++) {
        NSDictionary* dicStory = [array objectAtIndex:i];
        SimpleStoryInfo* story = [[SimpleStoryInfo alloc] initWithDictionary:dicStory];
        [m_arrayStoryList addObject:story];
        [story release];
    }
    return self;
}
- (void) dealloc {
    [m_arrayStoryList release];
    [super dealloc];
}
- (BOOL) downloadStoryListWithUrl:(NSString*)strUrl {
    NSLog(@"%@", strUrl);
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:strUrl]];
    if (dic == nil)
        return NO;
    NSArray* array = [dic objectForKey:keyStoryList];
    if (array == nil)
        return NO;
    m_arrayStoryList = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i ++) {
        NSDictionary* dicStory = [array objectAtIndex:i];
        SimpleStoryInfo* story = [[SimpleStoryInfo alloc] initWithDictionary:dicStory];
        [m_arrayStoryList addObject:story];
        [story release];
    }
    return YES;
}
@end
