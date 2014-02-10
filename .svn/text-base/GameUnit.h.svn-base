//
//  GameUtils.h
//  MonkeyTime
//
//  Created by OCH on 11/01/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@class StoryInfo;
@class SimpleStoryInfo;

enum USER_TYPE {
    USER_REGISTER = 0,
    USER_FACEBOOK,
    USER_TWITTER,
};

@interface GameUnit : NSObject {
    NSMutableArray*     m_arrayDirs;
    NSMutableArray*     m_arrayMyStories;
    StoryInfo*          m_storyCurrent;
    int                 m_nSelectedPageIndex;
    int                 m_nSelectedStoryIndex;
    BOOL                m_bPreviewStoryMode;
    BOOL                m_bShareStory;
    NSString*           m_strUserName;
    NSString*           m_strPassword;
    int                 m_nUserType;
}

@property(nonatomic, assign) NSMutableArray* m_arrayDirs;
@property(nonatomic, assign) NSMutableArray* m_arrayMyStories;
@property(nonatomic, assign) StoryInfo* m_storyCurrent;
@property(nonatomic) int m_nSelectedPageIndex;
@property(nonatomic) int m_nSelectedStoryIndex;
@property(nonatomic) BOOL m_bPreviewStoryMode;
@property(nonatomic) BOOL m_bShareStory;
@property(nonatomic, assign) NSString* m_strUserName;
@property(nonatomic, assign) NSString* m_strPassword;
@property(nonatomic) int m_nUserType;

- (void) initData;
- (void) loadData;
- (void) saveData;
- (void) loadDirInfo;
- (void) loadStoryInfos;

- (void) setVipavoUser:(NSString*)username pwd:(NSString*)pwd; 
- (void) changePassword:(NSString*)newpwd;
//- (void) loadVideoFilePaths:(int)dirIndex;

- (void) createStoryWithName:(NSString*)strName;
- (void) createStoryWithSimpleStory:(SimpleStoryInfo*)simpleStory;
- (void) replaceStory:(StoryInfo*)story;
- (void) deleteCreatedCurrentStory;
- (void) addCreatedCurrentStoryInMyStories;
- (void) deleteStoryWithIndex:(int)index;
- (void) deleteStory:(StoryInfo*)story;
- (void) deleteStoryWithSimple:(SimpleStoryInfo*)story;
- (BOOL) shouldDownloadStory:(SimpleStoryInfo*)simpleStory;
- (BOOL) isExistStoryInDocument:(SimpleStoryInfo*)simpleStory;
- (int) getStoryIndexWithSimpleStory:(SimpleStoryInfo*)simpleStory;
- (int) getStoryIndexWithStoryName:(NSString*)strName;

- (NSString*) getUserStoryPath;
- (NSString *)applicationDocumentsDirectory;
- (NSString*) getVideoPath;
- (NSString*) getVideoSubPath;
- (NSString*) getCurrentDate:(BOOL)isFull;
- (void) ensureDirs:(NSString*)path;

- (BOOL) isExistDirectory:(NSString*)strPath;

- (void) removeFile:(NSString*)path;

- (void)applicationWillTerminate;

- (UIImage *) scaleAndRotateImage:(UIImage *)image;
- (UIImage *) scaleAndRotateImage:(UIImage *)image ORIENT:(UIImageOrientation)orient;

- (NSString*) getPhotoPath;
- (NSString*) getSavedPhotoPath:(UIImage*)image;

NSInteger sortName(NSString *obj1, NSString *obj2, void *reverse);

@end

extern GameUnit*	g_GameUnit;
