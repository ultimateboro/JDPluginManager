//
//  JDInstallProgressWindow.m
//  ExampleProject
//
//  Created by Markus Emrich on 09.03.13.
//  Copyright (c) 2013 nxtbgthng. All rights reserved.
//

#import "global.h"

#import "JDInstallProgressWindow.h"

@implementation JDInstallProgressWindow

- (id)initWithContentRect:(NSRect)contentRect;
{
    self = [super initWithContentRect:contentRect styleMask:NSTitledWindowMask | NSMiniaturizableWindowMask
                              backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        self.title = JDLocalize(@"keyInstallProgressTitle");
        self.minSize = NSMakeSize(568, 320);
        self.backgroundColor = [NSColor colorWithCalibratedWhite:0 alpha:0.77];
        self.opaque = NO;
        
        // setup scrollView
        NSView *contentView = self.contentView;
        NSScrollView *scrollView = [[[NSScrollView alloc] initWithFrame:NSInsetRect(contentView.bounds, 10, 10)] autorelease];
        scrollView.backgroundColor = [NSColor colorWithCalibratedWhite:0 alpha:0.77];
        scrollView.borderType = NSNoBorder;
        scrollView.hasVerticalScroller = YES;
        scrollView.hasHorizontalScroller = NO;
        scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [self.contentView addSubview:scrollView];
        
        // setup textView
        CGSize contentSize = scrollView.contentSize;
        CGRect contentSizeRect = NSMakeRect(0, 0,contentSize.width, contentSize.height);
        NSTextView *textView = [[[NSTextView alloc] initWithFrame:contentSizeRect] autorelease];
        textView.autoresizingMask = NSViewWidthSizable;
        textView.minSize = contentSize;
        textView.maxSize = NSMakeSize(FLT_MAX, FLT_MAX);
        textView.verticallyResizable = YES;
        textView.horizontallyResizable = YES;
        textView.selectable = NO;
        textView.editable = NO;
        textView.backgroundColor = [NSColor clearColor];
        textView.alignment = NSLeftTextAlignment;
        textView.textColor = [NSColor whiteColor];
        textView.font = [NSFont systemFontOfSize:13];
        textView.textContainer.containerSize = NSMakeSize(contentSize.width, FLT_MAX);
        textView.textContainer.widthTracksTextView = YES;
        [scrollView addSubview:textView];
        _textView = textView;
        
        // connect scrollView
        scrollView.documentView = textView;
        [self makeFirstResponder:textView];
    }
    return self;
}


- (void)appendLine:(NSString*)line;
{
    if (line && line.length > 0) {
        self.textView.string = [NSString stringWithFormat: @"%@\n%@", self.textView.string, line];
        [self scrollToBottom];
    }
}

- (void)scrollToBottom;
{
    [self.textView scrollRangeToVisible:NSMakeRange([self.textView.string length]-1,1)];
}

@end
