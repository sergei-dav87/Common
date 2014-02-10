//
//  DownloadedStoryList.h
//  Vipavo
//
//  Created by admin on 12/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum DOWNLOAD_STATE {
    DS_MUSTDOWNLOAD = 0,
    DS_DOWNLOADED,
    DS_EXIST
};
@interface SimpleStoryInfo : NSObject {
    NSString*   m_strStoryName;
    NSString*   m_strStoryNameWithDate;
    NSString*   m_strThumbnailUrl;
    int         m_nVersion;
    int         m_nPageCount;
    int         m_nDownloadState;
}

@property (nonatomic, assign) NSString* m_strStoryName;
@property (nonatomic, assign) NSString* m_strStoryNameWithDate;
@property (nonatomic, assign) NSString* m_strThumbnailUrl;
@property (nonatomic) int m_nVersion;
@property (nonatomic) int m_nPageCount;

- (id) initWithDictionary:(NSDictionary*)dic;
@end

@interface DownloadedStoryList : NSObject {
    NSMutableArray* m_arrayStoryList;
}

@property (nonatomic, assign) NSMutableArray* m_arrayStoryList;

- (id) initWithUrl:(NSString*)strUrl;
- (BOOL) downloadStoryListWithUrl:(NSString*)strUrl;

@end
