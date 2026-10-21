// GlassEffect.h - Liquid Glass backgrounds for the docked theme.

#import <UIKit/UIKit.h>

// Adds a glass view filling `host`, behind its other subviews, and returns it. A
// positive cornerRadius makes it a capsule (a circle when the host is square).
// Uses iOS 26 Liquid Glass where available, a dark system material otherwise.
UIVisualEffectView *FHAddGlass(UIView *host, CGFloat cornerRadius);
