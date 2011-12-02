//
//  Map.h
//  Pharos
//
//  Created by Zaidos on 12/19/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface Map : NSObject {	
	
	IBOutlet WebView *mapView;
	IBOutlet NSButton *buttonZoomIn;
	IBOutlet NSButton *buttonZoomOut;
	IBOutlet NSButton *buttonCenter;
	
	NSString *longitude;
	NSString *latitude;
	
	NSTimer *timer;
	
	int count;
}

@property (nonatomic, retain) IBOutlet WebView *mapView;
@property (nonatomic, retain) IBOutlet NSButton *buttonZoomIn;
@property (nonatomic, retain) IBOutlet NSButton *buttonZoomOut;
@property (nonatomic, retain) IBOutlet NSButton *buttonCenter;

@property (assign) NSTimer *timer;

@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *latitude;

- (IBAction)zoomInClick:(id)sender;
- (IBAction)zoomOutClick:(id)sener;
- (IBAction)centerClick:(id)sender;

- (void)setCoordinates:(NSString *)lng 
			   withLat:(NSString *)lat;

- (void)updateMap;

@end
