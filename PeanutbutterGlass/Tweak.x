// PeanutbutterGlass - adds Liquid Glass to Peanutbutter's passcode keypad.
#import <UIKit/UIKit.h>
#import "GlassEffect.h"

@interface PeanutbutterLockController : NSObject
@end

%hook PeanutbutterLockController

// Called by Peanutbutter for every keypad button. We let it build the button,
// then put a glass background behind it.
- (UIButton *)createKeypadButtonWithFrame:(CGRect)frame number:(NSInteger)number {
    UIButton *button = %orig;
    if ([button isKindOfClass:[UIButton class]]) {
        button.backgroundColor = [UIColor clearColor];   // let the glass show through
        FHAddGlass(button, MIN(frame.size.width, frame.size.height) / 2.0);
    }
    return button;
}

%end
