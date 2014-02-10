//
//  VideoThumbView.m
//  MyCamera
//
//  Created by Kwang on 11/10/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageThumbView.h"
#import "GameUnit.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageThumbView

@synthesize delegate;
@synthesize m_bSelected, m_bEnableTouch;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        m_bEnableTouch = YES;
        [self.layer setCornerRadius:4.0];
        self.layer.masksToBounds = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
//    if (self.delegate)
//        [self.delegate release];
    [m_imgThumb release];
    [m_imgSound release];
    [m_btnDelete release];
    [self removeGestureRecognizer:gestureLongPress];
    [gestureLongPress release];
    [super dealloc];
}

- (void) awakeFromNib {
    [m_imgThumb.layer setCornerRadius:5.0];
    m_imgThumb.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    [self setExistSound:NO];
    gestureLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]; 
    [self addGestureRecognizer:gestureLongPress]; 
}
- (void) setImage:(UIImage*)image {
    CGSize size = image.size;
    CGRect rect = m_imgThumb.frame;
    CGSize tarSize;
    CGSize orgSize = CGSizeMake(72, 72);
    CGFloat fx = orgSize.width/size.width;
    CGFloat fy = orgSize.height/size.height;
    CGFloat fV = (fx > fy) ? fy : fx;
    tarSize = CGSizeMake(size.width*fV, size.height*fV);
    CGRect frame = CGRectMake(rect.origin.x+(orgSize.width-tarSize.width)/2, rect.origin.y+(orgSize.height-tarSize.height)/2, tarSize.width, tarSize.height);
    m_imgThumb.frame = frame;
    m_imgThumb.image = image;
}
- (void) setExistSound:(BOOL)exist {
    m_imgSound.hidden = !exist;
}
- (void) setSelection:(BOOL)select {
    m_bSelected = select;
//    m_imgSound.hidden = !m_bSelected;
    if (self.delegate) {
        [self.delegate onSelection:self];
    }
}
- (void) setDeleteState:(BOOL)del {
    m_btnDelete.hidden = !del;
}
- (void) setEnableMoveFlag:(BOOL)enable {
    m_bEnableMove = enable;
}
- (void) setMovingState:(BOOL)state {
    if (m_bMovingState == state)
        return;
    m_bMovingState = state;
}
- (void) startShakeAnim {
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
    
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-2.0));
    CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(2.0));
    
    self.transform = leftWobble;  // starting point
    //    self.deleteButton.hidden = NO;
    
    [UIView animateWithDuration:0.125 delay:0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
        self.transform = rightWobble;
    }completion:^(BOOL finished){
    }];
    
}
- (void) stopAnim {
    [self.layer removeAllAnimations];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    self.transform = CGAffineTransformIdentity; // end here & auto-reverse
    [UIView commitAnimations];
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    if ([touches count] == 1 && [touch tapCount] == 1 && m_bEnableTouch) {
        [self setSelection:!m_bSelected];
    }
}
- (IBAction)onDelete:(id)sender {
    if (self.delegate && m_bEnableMove && m_bMovingState) {
        [self.delegate onDelete:self];
    }
    
}

- (void) longPress:(UILongPressGestureRecognizer*)gesture {
    if (m_bEnableMove == NO)
        return;
}
@end
