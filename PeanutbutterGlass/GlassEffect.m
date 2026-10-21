// GlassEffect.m - Liquid Glass backgrounds for the docked theme.

#import "GlassEffect.h"
#import <objc/message.h>

// iOS 26 Liquid Glass, looked up at runtime so this builds against any SDK. Where
// UIGlassEffect doesn't exist it falls back to a dark system material.
static UIVisualEffect *FHGlassEffect(void) {
    Class c = NSClassFromString(@"UIGlassEffect");
    SEL make = NSSelectorFromString(@"effectWithStyle:");
    if (c && [(id)c respondsToSelector:make]) {
        UIVisualEffect *e = ((id (*)(id, SEL, NSInteger))objc_msgSend)((id)c, make, 0);   // regular style
        if (e) return e;
    }
    return [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
}

// Adds a glass view filling `host`, behind its other subviews. A positive
// cornerRadius makes it a capsule (a circle when the host is square).
UIVisualEffectView *FHAddGlass(UIView *host, CGFloat cornerRadius) {
    UIVisualEffectView *v = [[UIVisualEffectView alloc] initWithEffect:FHGlassEffect()];
    v.frame = host.bounds;
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    v.userInteractionEnabled = NO;   // touches go to the host
    if (cornerRadius > 0) {
        SEL setConfig = NSSelectorFromString(@"setCornerConfiguration:");
        Class cfg = NSClassFromString(@"UICornerConfiguration");
        SEL capsule = NSSelectorFromString(@"capsuleConfiguration");
        if ([v respondsToSelector:setConfig] && cfg && [(id)cfg respondsToSelector:capsule]) {
            id conf = ((id (*)(id, SEL))objc_msgSend)((id)cfg, capsule);
            ((void (*)(id, SEL, id))objc_msgSend)(v, setConfig, conf);
        } else {
            v.layer.cornerRadius = cornerRadius;
            v.layer.masksToBounds = YES;
        }
    }
    [host insertSubview:v atIndex:0];
    return v;
}
