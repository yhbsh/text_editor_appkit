#import "app_delegate.h"
#import "main_text_view.h"
#import "main_window.h"

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
