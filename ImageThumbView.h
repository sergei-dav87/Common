//
//  VideoThumbView.h
//  MyCamera
//
//  Created by Kwang on 11/10/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageThumbViewDelegate;

@interface ImageThumbView : UIView {
    id<ImageThumbViewDelegate> delegate;
    IBOutlet UIImageView*   m_imgThumb;
    IBOutlet UIImageView*   m_imgSound;
    IBOutlet UIButton*      m_btnDelete;
    
    BOOL    m_bSelected;
    BOOL    m_bEnableTouch;
    BOOL    m_bMovingState;
    BOOL    m_bEnableMove;
    
    UILongPressGestureRecognizer* gestureLongPress;
}

@property (nonatomic, assign)id<ImageThumbViewDelegate> delegate;
@property(nonatomic) BOOL m_bSelected;
@property(nonatomic) BOOL m_bEnableTouch;

- (IBAction)onDelete:(id)sender;
- (void) setImage:(UIImage*)image;
- (void) setSelection:(BOOL)select;
- (void) setExistSound:(BOOL)exist;
- (void) setDeleteState:(BOOL)del;
- (void) setEnableMoveFlag:(BOOL)enable;
- (void) setMovingState:(BOOL)state;
- (void) startShakeAnim;
- (void) stopAnim;
@end

@protocol ImageThumbViewDelegate

- (void) onSelection:(id)sender;
- (void) onDelete:(id)sender;
@end