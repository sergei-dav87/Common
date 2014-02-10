//
//  GameUtils.m
//  MonkeyTime
//
//  Created by OCH on 11/01/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameUnit.h"
#import "StoryInfo.h"
#import "DownloadedStoryList.h"

GameUnit*			g_GameUnit;

@implementation GameUnit

@synthesize m_arrayDirs;
@synthesize m_arrayMyStories, m_storyCurrent;
@synthesize m_nSelectedPageIndex;
@synthesize m_nSelectedStoryIndex;
@synthesize m_bPreviewStoryMode, m_bShareStory;
@synthesize m_strUserName, m_strPassword;
@synthesize m_nUserType;

// on "init" you need to initialize your instance
- (id)init
{
	if( (self = [super init] )) {
		[self loadData];
	}
	return self;
}

- (void)dealloc {
    [m_arrayDirs release];
    [m_arrayMyStories release];
    if (m_strUserName != nil)
        [m_strUserName release];
    if (m_strPassword != nil)
        [m_strPassword release];
    if (m_storyCurrent != nil)
        [m_storyCurrent release];
    
	[super dealloc];
}

- (void) initData {
}
- (void) loadData {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ( [defaults boolForKey:@"firstBoot"] == NO ) 
    {
        [defaults setBool:YES forKey:@"firstBoot"];
        [defaults synchronize];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [self initData];
    } 
    else 
    {
    }
}
- (void) saveData {
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"firstBoot"];
	[defaults synchronize];
}
- (void) setVipavoUser:(NSString*)username pwd:(NSString*)pwd {
    if (m_strUserName != nil)
        [m_strUserName release];
    if (m_strPassword != nil)
        [m_strPassword release];
    m_strUserName = [[NSString alloc] initWithString:username];
    m_strPassword = [[NSString alloc] initWithString:pwd];
}
- (void) changePassword:(NSString*)newpwd {
    if (m_strPassword != nil)
        [m_strPassword release];
    m_strPassword = [[NSString alloc] initWithString:newpwd];
}
- (void) loadDirInfo {
    if (m_arrayDirs)
        [m_arrayDirs release];
    m_arrayDirs = [[NSMutableArray alloc] init];
	NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    NSString* strPath = [self getUserStoryPath];
    NSArray* _directoryList = [fileManager contentsOfDirectoryAtPath:strPath error:&error];
    if (error != nil) {
        NSLog(@"%@, %@", [error localizedDescription], [error localizedFailureReason]);
    }
    if ([self isExistDirectory:strPath] == NO) {
        [self ensureDirs:strPath];
    }
    NSEnumerator *_directoryEnumerator = [_directoryList objectEnumerator];
    NSString *fileName;
    BOOL isDir;
    while ((fileName = [_directoryEnumerator nextObject])) {
        NSString* strSubPath = [strPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:strSubPath isDirectory:&isDir]) {
            if (isDir) {
                NSArray* _subList = [fileManager contentsOfDirectoryAtPath:strSubPath error:&error];
                if (error != nil || [_subList count] == 0) {
                    [fileManager removeItemAtPath:strSubPath error:&error];
                }
                else {
                    [m_arrayDirs addObject:strSubPath];
                }
            }
        }
    }
//    [m_arrayDirs sortUsingFunction:sortName context:self];
}
- (void) loadStoryInfos {
    [self loadDirInfo];
    if (m_arrayMyStories)
        [m_arrayMyStories release];
    m_arrayMyStories = [[NSMutableArray alloc] init];
    int count = [m_arrayDirs count];
    for (int i = 0; i < count; i ++) {
        NSString* strPath = [m_arrayDirs objectAtIndex:i];
        if ([StoryInfo isValidStoryInfo:strPath] == NO) {
            [self removeFile:strPath];
            continue;
        }
        StoryInfo* story = [[StoryInfo alloc] initWithStoryInfoPath:strPath];
        [m_arrayMyStories addObject:story];
        [story release];
    }
}
- (NSString*) getUserStoryPath {
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:m_strUserName];//kgh
}
//- (void) loadVideoFilePaths:(int)dirIndex {
//    if (m_arrayVideoFilePaths) {
//        [m_arrayVideoFilePaths removeAllObjects];
//        [m_arrayVideoFilePaths release];
//    }
//    NSString* strDirPath = [m_arrayDirs objectAtIndex:m_nSelectedDirIndex];
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    m_arrayVideoFilePaths = [[NSMutableArray alloc] init];
//    NSMutableArray* array = [[NSMutableArray alloc] init];
//    if ([fileManager fileExistsAtPath:strDirPath]) {
//        NSError* error;
//        NSArray* _directoryList = [fileManager contentsOfDirectoryAtPath:strDirPath error:&error];        
//        NSEnumerator *_directoryEnumerator = [_directoryList objectEnumerator];
//        NSString *fileName;
//        BOOL isDir;
//        while ((fileName = [_directoryEnumerator nextObject])) {
//            NSString* strSubPath = [strDirPath stringByAppendingPathComponent:fileName];
//            if ([fileManager fileExistsAtPath:strSubPath isDirectory:&isDir]) {
//                if (!isDir) {
//                    [array addObject:[NSString stringWithString:strSubPath]];
//                }
//            }
//        }
//    }
//    for (int i = [array count]-1; i >= 0; i --) {
//        [m_arrayVideoFilePaths addObject:[array objectAtIndex:i]];
//    }
//    [m_arrayVideoFilePaths sortUsingFunction:sortName context:self];
//    [array release];
//}
- (void)applicationWillTerminate {
	[self saveData];
}

- (void) createStoryWithName:(NSString*)strName {
    m_storyCurrent = [[StoryInfo alloc] initWithStoryName:strName];
}

- (void) createStoryWithSimpleStory:(SimpleStoryInfo*)simpleStory {
    [self deleteStoryWithSimple:simpleStory];
    StoryInfo* story = [[StoryInfo alloc] initWithSimpleStory:simpleStory];
    [m_arrayMyStories addObject:story];
    [story release];
}
- (void) replaceStory:(StoryInfo*)story {
    int index = [self getStoryIndexWithStoryName:story.m_strStoryNameWithDate];
    if (index == -1)
        [m_arrayMyStories addObject:story];
    else
        [m_arrayMyStories replaceObjectAtIndex:index withObject:story];
}
- (void) deleteCreatedCurrentStory {
    [self removeFile:m_storyCurrent.m_strPath];
    [m_storyCurrent release];
    m_storyCurrent = nil;
}
- (void) addCreatedCurrentStoryInMyStories {
    [m_arrayMyStories addObject:m_storyCurrent];
    [m_storyCurrent release];
    m_storyCurrent = nil;
    [self deleteCreatedCurrentStory];
}
- (void) deleteStoryWithIndex:(int)index {
    StoryInfo* story = [m_arrayMyStories objectAtIndex:index];
    [self removeFile:story.m_strPath];
    [m_arrayMyStories removeObject:story];
}
- (void) deleteStory:(StoryInfo*)story {
    [self removeFile:story.m_strPath];
    [m_arrayMyStories removeObject:story];
}
- (void) deleteStoryWithSimple:(SimpleStoryInfo*)simpleStory {
    int index = [self getStoryIndexWithStoryName:simpleStory.m_strStoryNameWithDate];
    if (index == -1)
        return;
    StoryInfo* story = [m_arrayMyStories objectAtIndex:index];
    [self removeFile:story.m_strPath];
    [m_arrayMyStories removeObject:story];
}
- (BOOL) shouldDownloadStory:(SimpleStoryInfo*)simpleStory {
    int index = [self getStoryIndexWithSimpleStory:simpleStory];
    if (index == -1)
        return YES;
    else
        return NO;
}
- (BOOL) isExistStoryInDocument:(SimpleStoryInfo*)simpleStory {
    return ([self getStoryIndexWithSimpleStory:simpleStory] != -1) ? YES : NO;
}
- (int) getStoryIndexWithSimpleStory:(SimpleStoryInfo*)simpleStory {
    int index = -1;
    for (int i = 0; i < [m_arrayMyStories count]; i ++) {
        StoryInfo* story = [m_arrayMyStories objectAtIndex:i];
        if ([story.m_strStoryNameWithDate compare:simpleStory.m_strStoryNameWithDate] == NSOrderedSame) {
            if (story.m_nVersion == simpleStory.m_nVersion) {
                index = i;
                break;
            }
        }
    }
    return index;
}
- (int) getStoryIndexWithStoryName:(NSString*)strName {
    int index = -1;
    for (int i = 0; i < [m_arrayMyStories count]; i ++) {
        StoryInfo* story = [m_arrayMyStories objectAtIndex:i];
        if ([story.m_strStoryNameWithDate compare:strName] == NSOrderedSame) {
            index = i;
            break;
        }
    }
    return index;
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

- (NSString*) getVideoPath
{
    NSString* path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"videos"];
    [self ensureDirs:path];
    return path;
}

- (NSString*) getVideoSubPath {
    NSString* strPath = [[self getVideoPath] stringByAppendingPathComponent:[self getCurrentDate:NO]];
    return strPath;
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

- (void) createVideoDirectory {
    NSString* path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"videos"];
    [self ensureDirs:path];
}
- (void) createCategoryDirectory {
    [self ensureDirs:[self getVideoSubPath]];
}
- (BOOL) isExistDirectory:(NSString*)strPath {
	NSFileManager* fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:strPath];
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

- (UIImage *) scaleAndRotateImage:(UIImage *)image
{
	
	CGImageRef imgRef = image.CGImage;
	
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	int kMaxResolution = MAX(width, height); // Or whatever
    
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
	if (width > kMaxResolution || height > kMaxResolution) {
		CGFloat ratio = width/height;
		if (ratio > 1) {
			bounds.size.width = kMaxResolution;
			bounds.size.height = bounds.size.width / ratio;
		}
		else {
			bounds.size.height = kMaxResolution;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	UIImageOrientation orient = image.imageOrientation;
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
			
		case UIImageOrientationLeftMirrored: //EXIF = 5
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRightMirrored: //EXIF = 7
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	}
	else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	//[self setRotatedImage:imageCopy];
	return imageCopy;
}

- (UIImage *) scaleAndRotateImage:(UIImage *)image ORIENT:(UIImageOrientation)orient
{
	
	CGImageRef imgRef = image.CGImage;
	
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	int kMaxResolution = MAX(width, height); // Or whatever
    
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
	if (width > kMaxResolution || height > kMaxResolution) {
		CGFloat ratio = width/height;
		if (ratio > 1) {
			bounds.size.width = kMaxResolution;
			bounds.size.height = bounds.size.width / ratio;
		}
		else {
			bounds.size.height = kMaxResolution;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
    
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
			
		case UIImageOrientationLeftMirrored: //EXIF = 5
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRightMirrored: //EXIF = 7
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	}
	else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	//[self setRotatedImage:imageCopy];
	return imageCopy;
}

- (NSString*) getPhotoPath
{
    NSString* path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"photos"];
    [self ensureDirs:path];
    return path;
}

- (NSString*) getSavedPhotoPath:(UIImage*)image
{
    NSString* path = nil;
    
    NSString* file_name = [[self getCurrentDate:YES] stringByAppendingPathExtension:@"png"];
    path = [[self getPhotoPath] stringByAppendingPathComponent:file_name];
//    NSLog(@"saved path = %@", path);
    NSData* imgData = UIImagePNGRepresentation(image);
    [imgData writeToFile:path atomically:YES];
    
    return path;
}

NSInteger sortName(NSString *obj1, NSString *obj2, void *reverse) {
//    NSComparisonResult result = 
    return [obj2 caseInsensitiveCompare:obj1];
}

@end
