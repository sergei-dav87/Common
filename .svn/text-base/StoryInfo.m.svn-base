//
//  StoryInfo.m
//  Vipavo
//
//  Created by admin on 11/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoryInfo.h"
#import "Global.h"
#import "DownloadedStoryList.h"
#import "Network.h"
#import "GameUnit.h"


@implementation StoryInfo

@synthesize m_strStoryName, m_strPath, m_strStoryNameWithDate;
@synthesize m_arrayItems;
@synthesize m_nVersion, m_nPageCount;

+ (BOOL) isValidStoryInfo:(NSString*)path {
    NSString* str = [path stringByAppendingPathComponent:STORYINFO_FILENAME];
    if ([g_GameUnit isExistDirectory:str] == NO)
        return NO;
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:str];
    NSArray* array = [NSArray arrayWithArray:[dic objectForKey:keyPageInfos]];
    BOOL bRet = YES;
    if (array == nil || [array count] == 0)
        bRet = NO;
    [dic release];
    return bRet;
}
- (id) initWithStoryName:(NSString*) strName {
    [self init];
    m_strStoryName = [[NSString alloc] initWithString:strName];
    m_strStoryNameWithDate = [[NSString alloc] initWithFormat:@"%@-%@", strName, [self getCurrentDate:YES]];
    m_arrayItems = [[NSMutableArray alloc] init];
    NSString* strPath= [[g_GameUnit getUserStoryPath] stringByAppendingPathComponent:m_strStoryNameWithDate];
    m_strPath = [[NSString alloc] initWithString:strPath];
    [self ensureDirs:m_strPath];
    m_nVersion = 1;
    m_nPageCount = 0;
    return self;
}

- (id) initWithStoryInfoPath:(NSString*) path {
    [self init];
    m_strPath = [[NSString alloc] initWithString:path];
    NSString* str = [m_strPath stringByAppendingPathComponent:STORYINFO_FILENAME];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:str];
    m_strStoryName = [[NSString alloc] initWithString:[dic objectForKey:keyStoryName]];
    m_strStoryNameWithDate = [[NSString alloc] initWithString:[dic objectForKey:keyStoryNameWithDate]];
    m_nVersion = [[dic objectForKey:keyVersion] intValue];
    m_nPageCount = [[dic objectForKey:keyPageCount] intValue];
    m_arrayItems = [[NSMutableArray alloc] initWithArray:[dic objectForKey:keyPageInfos]];
    return self;
}

- (id) initWithSimpleStory:(SimpleStoryInfo*) simpleStory {
    [self init];
    m_strStoryName = [[NSString alloc] initWithString:simpleStory.m_strStoryName];
    m_strStoryNameWithDate = [[NSString alloc] initWithString:simpleStory.m_strStoryNameWithDate];
    m_nPageCount = simpleStory.m_nPageCount;
    m_nVersion = simpleStory.m_nVersion;
    NSString* strPath= [[g_GameUnit getUserStoryPath] stringByAppendingPathComponent:m_strStoryNameWithDate];
    m_strPath = [[NSString alloc] initWithString:strPath];
    [self ensureDirs:m_strPath];
    NSURL* url = [NSURL URLWithString:[Network getServerDownloadFileUrl:m_strStoryNameWithDate filename:STORYINFO_FILENAME]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    strPath = [m_strPath stringByAppendingPathComponent:STORYINFO_FILENAME];
    [data writeToFile:strPath atomically:YES];
    NSDictionary* dicStoryInfo = [NSDictionary dictionaryWithContentsOfFile:strPath];
    m_arrayItems = [[NSMutableArray alloc] initWithArray:[dicStoryInfo objectForKey:keyPageInfos]];
    for (int i = 0; i < m_nPageCount; i ++) {
        NSDictionary* dic = [m_arrayItems objectAtIndex:i];
        NSString* strImgName = [dic objectForKey:KEY_STORY_ITEM_IMAGE];
        NSLog(@"%@", [Network getServerDownloadFileUrl:m_strStoryNameWithDate filename:strImgName]);
        NSURL* urlFile = [NSURL URLWithString:[Network getServerDownloadFileUrl:m_strStoryNameWithDate filename:strImgName]];
        NSData* data = [NSData dataWithContentsOfURL:urlFile];
        NSString* strPath = [m_strPath stringByAppendingPathComponent:strImgName];
        [data writeToFile:strPath atomically:YES];
        NSString* strSndName = [dic objectForKey:KEY_STORY_ITEM_SOUND];
        if (strSndName != nil && [strSndName length] > 0) {
            urlFile = [NSURL URLWithString:[Network getServerDownloadFileUrl:m_strStoryNameWithDate filename:strSndName]];
            data = [NSData dataWithContentsOfURL:urlFile];
            strPath = [m_strPath stringByAppendingPathComponent:strSndName];
            [data writeToFile:strPath atomically:YES];
        }
    }
    
    return self;
}
- (void) loadStoryInfoWithPath:(NSString*) path {
    
}
- (void) saveStoryInfo {
    NSString* strPath = [m_strPath stringByAppendingPathComponent:STORYINFO_FILENAME];
    [self removeFile:strPath];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setObject:m_strStoryName forKey:keyStoryName];
    [dic setObject:m_strStoryNameWithDate forKey:keyStoryNameWithDate];
    [dic setObject:[NSNumber numberWithInt:[m_arrayItems count]] forKey:keyPageCount];
    [dic setObject:[NSNumber numberWithInt:m_nVersion] forKey:keyVersion];
    [dic setObject:m_arrayItems forKey:keyPageInfos];
    [dic writeToFile:strPath atomically:YES];
    [dic release];
}

- (void) dealloc {
    [m_strStoryName release];
    [m_strStoryNameWithDate release];
    [m_arrayItems release];
    [m_strPath release];
    [super dealloc];
}

- (NSString*) getStoryInfoFilePath {
    NSString* str = [m_strPath stringByAppendingPathComponent:STORYINFO_FILENAME];
    return str;
}
- (int) getPageCount {
    return [m_arrayItems count];
}
- (void) addItemWithImage:(UIImage*) image {
    NSString* path = nil;
    NSString* file_name = [[self getCurrentDate:YES] stringByAppendingPathExtension:@"png"];
    path = [m_strPath stringByAppendingPathComponent:file_name];
    //    NSLog(@"saved path = %@", path);
    NSData* imgData = UIImagePNGRepresentation(image);
    [imgData writeToFile:path atomically:YES];
    [self addItemWithImageName:file_name];
}
- (void) addItemWithImageName:(NSString*) strImage {
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setObject:strImage forKey:KEY_STORY_ITEM_IMAGE];
    [m_arrayItems addObject:dic];
    [dic release];
}
- (NSString*) addItemWithSound:(int)index {
    NSString* path = nil;
    NSString* file_name = [[self getCurrentDate:YES] stringByAppendingPathExtension:@"wav"];
    path = [m_strPath stringByAppendingPathComponent:file_name];
    //    NSLog(@"saved path = %@", path);
    [self addItemWithSoundName:file_name index:index];
    return path;
}
- (void) addItemWithSoundName:(NSString*) strSound index:(int)index {
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    [dic setObject:strSound forKey:KEY_STORY_ITEM_SOUND];
//    [m_arrayItems addObject:dic];
//    [dic release];
}
- (void) removeItemWithIndex:(int)index removefile:(BOOL)remove {
    if ([m_arrayItems count] > index && index >= 0) {
        if (remove) {
            [self removeItemSoundWithIndex:index];
            [self removeItemImageWithIndex:index];
        }
        [m_arrayItems removeObjectAtIndex:index];
    }
}
- (void) removeItemImageWithIndex:(int)index {
    if ([m_arrayItems count] <= index || index < 0) 
        return;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    NSString* strImage = [dic objectForKey:KEY_STORY_ITEM_IMAGE];
    if (strImage != nil) {
        NSString* strPath = [m_strPath stringByAppendingPathComponent:strImage];
        [self removeFile:strPath];
    }
    [dic removeObjectForKey:KEY_STORY_ITEM_IMAGE];
    return;
}
- (void) removeItemSoundWithIndex:(int)index {
    if ([m_arrayItems count] <= index || index < 0) 
        return;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    NSString* strSound = [dic objectForKey:KEY_STORY_ITEM_SOUND];
    if (strSound != nil) {
        NSString* strPath = [m_strPath stringByAppendingPathComponent:strSound];
        [self removeFile:strPath];
    }
    [dic removeObjectForKey:KEY_STORY_ITEM_SOUND];
//    [dic setObject:strSound forKey:KEY_STORY_ITEM_SOUND];
    return;
}
- (void) changeItemImageNameWithIndex:(int)index imagename:(NSString*) strImage {
    if ([m_arrayItems count] <= index || index < 0) 
        return;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    [dic removeObjectForKey:KEY_STORY_ITEM_IMAGE];
    [dic setObject:strImage forKey:KEY_STORY_ITEM_IMAGE];
    return;
}
- (void) changeItemSoundNameWithIndex:(int)index soundname:(NSString*) strSound {
    if ([m_arrayItems count] <= index || index < 0) 
        return;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    [dic removeObjectForKey:KEY_STORY_ITEM_SOUND];
    [dic setObject:strSound forKey:KEY_STORY_ITEM_SOUND];
    return;
}
- (NSString*) getItemImageNameWithIndex:(int)index {
    if ([m_arrayItems count] <= index || index < 0) 
        return nil;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    NSString* str = [dic objectForKey:KEY_STORY_ITEM_IMAGE];
    return str;
}
- (NSString*) getItemImagePathWithIndex:(int)index {
    if ([m_arrayItems count] <= index || index < 0) 
        return nil;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    NSString* str = [dic objectForKey:KEY_STORY_ITEM_IMAGE];
    return [m_strPath stringByAppendingPathComponent:str];
}
- (NSString*) getItemSoundNameWithIndex:(int)index {
    if ([m_arrayItems count] <= index || index < 0) 
        return nil;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    NSString* str = [dic objectForKey:KEY_STORY_ITEM_SOUND];
    return str;
}
- (NSString*) getItemSoundPathWithIndex:(int)index {
    NSString* str = [self getItemSoundNameWithIndex:index];
    if (str == nil)
        return nil;
    return [m_strPath stringByAppendingPathComponent:str];
}
- (BOOL) isExistItemSoundWithIndex:(int)index {
    if ([m_arrayItems count] <= index || index < 0) 
        return NO;
    NSMutableDictionary* dic = [m_arrayItems objectAtIndex:index];
    NSString* str = [dic objectForKey:KEY_STORY_ITEM_SOUND];
    if (str == nil || [str length] == 0)
        return NO;
    return YES;
}

- (NSString*) getCurrentDate:(BOOL)isFull
{
    NSString* path = nil;
    
    if (isFull) {
        CFAbsoluteTime at = CFAbsoluteTimeGetCurrent();
        CFTimeZoneRef timeZone = CFTimeZoneCopySystem();
        CFGregorianDate data = CFAbsoluteTimeGetGregorianDate(at, timeZone);
        CFRelease(timeZone);
        path = [NSString stringWithFormat:@"%d%02d%02d-%02d%02d%02d", data.year, data.month, data.day, data.hour, data.minute,(int)data.second];
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm:ss"];
        
        NSDate *now = [[NSDate alloc] init];
        
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        
        NSString* str_date = [dateFormatter stringFromDate:now];
        //        NSString* str_time = [timeFormatter stringFromDate:now];
        
        [dateFormatter release];
        [timeFormatter release];
        [now release];
        [usLocale release];
        
        path = [NSString stringWithFormat:@"%@", str_date];
    }
    
    return path;
}
- (void) removeFile:(NSString*)path {
	NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
}
#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (void) ensureDirs:(NSString*)path 
{
	NSFileManager* fileManager = [NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:path]) {
		return;
	}
	[fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
}

- (NSString*)ResNameForDevice:(NSString*) name
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [NSString stringWithFormat:@"%@.png", name];
    } else {
        return [NSString stringWithFormat:@"%@@3x.png", name];
    }
    return @"";
}

@end
