#import "main_text_view.h"

@implementation MainTextView

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
  NSDictionary *attributes = @{NSFontAttributeName : [NSFont systemFontOfSize:18], NSForegroundColorAttributeName : NSColor.whiteColor};
  NSSize textSize = [self.text sizeWithAttributes:attributes];
  CGFloat y = self.bounds.size.height - textSize.height;
  [self.text drawAtPoint:NSMakePoint(0, y) withAttributes:attributes];

  NSRect cursorRect = NSMakeRect(textSize.width, y, 2, textSize.height);
  [[NSColor whiteColor] set];
  NSRectFill(cursorRect);
}

@end
