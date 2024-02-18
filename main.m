#import "app_delegate.h"
#import <AppKit/AppKit.h>

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSApplication *application = [NSApplication sharedApplication];
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    application.delegate = appDelegate;
    [application run];
  }

  return 0;
}
