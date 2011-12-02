//
//  Map.m
//  Pharos
//
//  Created by Zaidos on 12/19/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import "Map.h"
#import <WebKit/WebKit.h>
#import "GPBWC.h"

@implementation Map

@synthesize buttonZoomIn;
@synthesize buttonZoomOut;
@synthesize mapView;
@synthesize buttonCenter;
@synthesize longitude;
@synthesize latitude;
@synthesize timer;

- (void) dealloc {
	[buttonZoomIn release];
	[buttonZoomOut release];
	[mapView release];
	
	[super dealloc];
}

- (void)awakeFromNib {
	
	NSURL *mapFileURL = [NSURL URLWithString:@"http://www.zaidox.com/map.html"];
	[[mapView mainFrame] loadRequest:[NSURLRequest requestWithURL:mapFileURL]];
	[[[mapView mainFrame] frameView] setAllowsScrolling:NO];
	[mapView setNeedsDisplay:YES];
	
	count = 0;
}

- (IBAction)zoomInClick:(id)sender {

	id map = [mapView windowScriptObject];
	NSString *jsCmd = @"map.zoomIn();";
	[map evaluateWebScript:jsCmd];
}

- (IBAction)zoomOutClick:(id)sender {
	
	id map = [mapView windowScriptObject];
	NSString *jsCmd = @"map.zoomOut();";
	[map evaluateWebScript:jsCmd];
}

- (IBAction)centerClick:(id)sender {
	
	NSTimer *newTimer = [NSTimer 
						 scheduledTimerWithTimeInterval:5.0
						 target:self 
						 selector:@selector(updateMap:)
						 userInfo:nil
						 repeats:YES];
	
	self.timer = newTimer;
}

// Updates coordinates
- (void)setCoordinates:(NSString *)lng 
			   withLat:(NSString *)lat {
	
	longitude = lng;
	latitude = lat;
	count++;
	
	if (count > 5) {
		[self updateMap];
		count = 0;
	}

}

- (void)updateMap {
	id map = [mapView windowScriptObject];
	NSString *jsCmd = [NSString 
					   stringWithFormat:@"map.setCenter(new google.maps.LatLng(%@, %@));", 
					   latitude, longitude];
	NSLog(@"%@", jsCmd);
	[map evaluateWebScript:jsCmd];
}

@end
