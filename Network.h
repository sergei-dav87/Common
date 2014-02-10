//
//  Network.h
//  Vipavo
//
//  Created by admin on 12/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef DEBUG
    #define URL_SERVER      @"http://175.160.115.1:81/Vipavo/"
#else
    #define URL_SERVER      @"http://vipavo.com/Vipavo/"
#endif
#define URL_LOGIN       @"login.php?user_id=%@&user_pwd=%@"
#define URL_SIGNUP      @"signup.php?user_id=%@&user_pwd=%@"
#define URL_CHANGEPWD   @"changePwd.php?user_id=%@&user_pwd=%@"
#define URL_FORGOTPWD   @"forgotpwd.php?username=%@"
#define URL_UPLOAD      @"save_story.php"
#define URL_DOWNLODSTORYLIST      @"download_story.php?user_id=%@"
#define URL_DOWNLOADURL      @"upload/%@/%@"
#define URL_DOWNLOADURL_LIST      @"upload/%@"
#define URL_DELETESTORY      @"delete_story.php?story_name_with_date=%@"

enum LOGIN_VALUE {
    LOGIN_OK = 0,
    LOGIN_INVALID_USER,
    LOGIN_INVALID_PWD,
};

@interface Network : NSObject

+(NSString*) getServerLoginUrl:(NSString*)username pwd:(NSString*)pwd;
+(NSString*) getServerSignupUrl:(NSString*)username pwd:(NSString*)pwd;
+(NSString*) getServerChangePwd:(NSString*)username pwd:(NSString*)pwd;
+(NSString*) getServerForgotPwd:(NSString*)username;
+(NSString*) getServerUploadUrl;
+(NSString*) getServerDownloadStoryListFileNameUrl:(NSString*)username;
+(NSString*) getServerDownloadStoryListUrl:(NSString*)filename;
+(NSString*) getServerDownloadFileUrl:(NSString*)storynamewithdate filename:(NSString*)filename;
+(NSString*) getServerDeleteStoryUrl:(NSString*)storynamewithdate;
@end
