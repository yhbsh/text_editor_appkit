#import "main_window.h"
#import "main_text_view.h"

@implementation MainWindow
- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
  self = [super initWithContentRect:contentRect styleMask:style backing:bufferingType defer:flag];
  self.buff = [[NSMutableString alloc] init];

  MainTextView *textView = [[MainTextView alloc] initWithFrame:self.contentView.bounds];
  textView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

  [self.contentView addSubview:textView];

  return self;
}

- (void)keyDown:(NSEvent *)event {
  if ([event keyCode] == 51) { // Key code for the Delete key
    if (self.buff.length > 0) {
      [self.buff deleteCharactersInRange:NSMakeRange(self.buff.length - 1, 1)];
    }
  } else {
    NSString *characters = [event characters];
    [self.buff appendString:characters];
  }

  MainTextView *textView = (MainTextView *)self.contentView.subviews.firstObject;
  textView.text = self.buff;
  [textView setNeedsDisplay:YES];
}

@end
