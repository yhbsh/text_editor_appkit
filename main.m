#import <AppKit/AppKit.h>

@interface MainWindow : NSWindow
@property(strong) NSMutableString *buff;
@end

@interface MainTextView : NSView
@property(strong) NSString *text;
@end

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property(strong) NSWindow *window;
@end

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

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  NSRect frame = [[NSScreen mainScreen] frame];
  NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable;

  self.window = [[MainWindow alloc] initWithContentRect:frame styleMask:style backing:NSBackingStoreBuffered defer:NO];
  [self.window makeKeyAndOrderFront:nil];
  [self.window setBackgroundColor:[NSColor colorWithRed:0 green:0 blue:0 alpha:1.0]];

  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
  [NSApp activateIgnoringOtherApps:YES];

  NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@""];
  NSMenuItem *appMenuItem = [[NSMenuItem alloc] init];
  [mainMenu addItem:appMenuItem];

  NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"Hello World"];
  NSString *appName = [[NSProcessInfo processInfo] processName];
  NSString *quitTitle = [NSString stringWithFormat:@"Quit %@", appName];
  NSMenuItem *quitMenuItem = [[NSMenuItem alloc] initWithTitle:quitTitle action:@selector(terminate:) keyEquivalent:@"q"];
  [quitMenuItem setKeyEquivalentModifierMask:NSEventModifierFlagCommand];
  [appMenu addItem:quitMenuItem];

  [appMenuItem setSubmenu:appMenu];
  [NSApp setMainMenu:mainMenu];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
  return YES;
}

@end

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSApplication *application = [NSApplication sharedApplication];
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    application.delegate = appDelegate;
    [application run];
  }

  return 0;
}
