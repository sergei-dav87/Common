//
//  StoryInfo.h
//  Vipavo
//
//  Created by admin on 11/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY_STORY_ITEM_IMAGE    @"image"
#define KEY_STORY_ITEM_SOUND    @"sound"

#define STORYINFO_FILENAME  @"StoryInfo.plist"

@class SimpleStoryInfo;

@interface StoryInfo : NSObject {
    NSString*   m_strPath;
    NSString*   m_strStoryName;
    NSString*   m_strStoryNameWithDate;
    NSMutableArray* m_arrayItems;
    int         m_nVersion;
    int         m_nPageCount;
}

@property (nonatomic, assign) NSString* m_strStoryName;
@property (nonatomic, assign) NSString* m_strStoryNameWithDate;
@property (nonatomic, assign) NSString* m_strPath;
@property (nonatomic, assign) NSMutableArray* m_arrayItems;
@property (nonatomic) int m_nVersion;
@property (nonatomic) int m_nPageCount;

+ (BOOL) isValidStoryInfo:(NSString*)path;

- (id) initWithStoryName:(NSString*) strName;
- (id) initWithSimpleStory:(SimpleStoryInfo*) simpleStory;
- (id) initWithStoryInfoPath:(NSString*) path;
- (void) loadStoryInfoWithPath:(NSString*) path;
- (void) saveStoryInfo;

- (void) addItemWithImage:(UIImage*) image;
- (void) addItemWithImageName:(NSString*) strImage;
- (void) addItemWithSoundName:(NSString*) strImage index:(int)index;
- (NSString*) addItemWithSound:(int)index;
- (void) removeItemWithIndex:(int)index removefile:(BOOL)remove;
- (void) removeItemImageWithIndex:(int)index;
- (void) removeItemSoundWithIndex:(int)index;
- (void) changeItemImageNameWithIndex:(int)index imagename:(NSString*) strImage;
- (void) changeItemSoundNameWithIndex:(int)index soundname:(NSString*) strSound;
- (NSString*) getItemImageNameWithIndex:(int)index;
- (NSString*) getItemImagePathWithIndex:(int)index;
- (NSString*) getItemSoundNameWithIndex:(int)index;
- (NSString*) getItemSoundPathWithIndex:(int)index;
- (BOOL) isExistItemSoundWithIndex:(int)index;

- (NSString*) getStoryInfoFilePath;

- (void) removeFile:(NSString*)path;

- (int) getPageCount;

- (NSString*) getCurrentDate:(BOOL)isFull;

- (NSString *)applicationDocumentsDirectory;
- (NSString*) getCurrentDate:(BOOL)isFull;
- (void) ensureDirs:(NSString*)path;

@end
