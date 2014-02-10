//
//  Network.m
//  Vipavo
//
//  Created by admin on 12/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Network.h"

@implementation Network

+(NSString*) getServerLoginUrl:(NSString*)username pwd:(NSString*)pwd {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_LOGIN, username, pwd]];
    NSLog(@"%@", strUrl);
    return strUrl;
}
+(NSString*) getServerSignupUrl:(NSString*)username pwd:(NSString*)pwd {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_SIGNUP, username, pwd]];
    return strUrl;
}
+(NSString*) getServerChangePwd:(NSString*)username pwd:(NSString*)pwd {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_CHANGEPWD, username, pwd]];
    return strUrl;
}
+(NSString*) getServerForgotPwd:(NSString*)username {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_FORGOTPWD, username]];
    return strUrl;
}
+(NSString*) getServerUploadUrl {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, URL_UPLOAD];
    return strUrl;
}
+(NSString*) getServerDownloadStoryListFileNameUrl:(NSString*)username {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_DOWNLODSTORYLIST, username]];
    return strUrl;
}
+(NSString*) getServerDownloadStoryListUrl:(NSString*)filename {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_DOWNLOADURL_LIST, filename]];
    return strUrl;
}
+(NSString*) getServerDownloadFileUrl:(NSString*)storynamewithdate filename:(NSString*)filename {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_DOWNLOADURL, storynamewithdate, filename]];
    return strUrl;
}
+(NSString*) getServerDeleteStoryUrl:(NSString*)storynamewithdate {
    NSString* strUrl = [NSString stringWithFormat:@"%@%@", URL_SERVER, [NSString stringWithFormat:URL_DELETESTORY, storynamewithdate]];
    return strUrl;
}
@end
