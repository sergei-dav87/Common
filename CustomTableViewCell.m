
#import "CustomTableViewCell.h"
//#import "VideoThumbView.h"

@implementation CustomTableViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
	{
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
}

- (void)dealloc
{
    [m_viewThumb release];
    [m_labelTitle release];
    [super dealloc];
}
- (void) setDirInfo:(NSString*)strDirPath {
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:strDirPath]) {
//        NSError* error;
//        NSDictionary* attributes = [fileManager attributesOfItemAtPath:strDirPath error:&error];
//        NSDate *creationDate = [attributes objectForKey:NSFileCreationDate];
//        NSArray* _directoryList = [fileManager contentsOfDirectoryAtPath:strDirPath error:&error];        
//        NSEnumerator *_directoryEnumerator = [_directoryList objectEnumerator];
//        NSString *fileName;
//        BOOL isDir;
//        int count = 0;
//        NSString* firstFileName;
//        while ((fileName = [_directoryEnumerator nextObject])) {
//            NSString* strSubPath = [strDirPath stringByAppendingPathComponent:fileName];
//            if ([fileManager fileExistsAtPath:strSubPath isDirectory:&isDir]) {
//                if (!isDir) {
////                    if (count == 0)
//                        firstFileName = [NSString stringWithString:fileName];
//                    count ++;
//                }
//            }
//        }
////        m_labelTitle.text = [NSString stringWithFormat:@"%@ (%d)", [self getDateString:creationDate], count];
//        [m_labelTitle setText:[NSString stringWithFormat:@"%@ (%d)", [self getDateString:creationDate], count]];
//        NSString* strNib;
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            strNib = @"VideoThumbView";
//        else
//            strNib = @"VideoThumbView_iPad";
//        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:strNib owner:nil options:nil];
//        
//        VideoThumbView* myView = [nibViews objectAtIndex:0];
//        [myView setVideoFile:[strDirPath stringByAppendingPathComponent:firstFileName]];
//        myView.frame = CGRectMake(0, 0, m_viewThumb.bounds.size.width, m_viewThumb.bounds.size.height);
//        myView.m_bEnableTouch = NO;
//        myView.userInteractionEnabled = NO;
//        [m_viewThumb addSubview:myView];
//    }
//    else {
//    }
}
- (NSString*) getDateString:(NSDate*)date {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"ccc, LLL d, yyyy"];
    
    return [formatter stringFromDate:date];
    
}
@end
