//
//  GPBWC.h
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GPBWC : NSObject {
	
	// Parsing string.
	NSString *parsingString;
	
	// Sentence description.
	NSString *description;
	
	// Sentence identifier
	NSString *sentenceIdentifier;
	
	// Timestamp
	NSNumber *timeStamp;
	
	// Latitude of next waypoint.
	NSNumber *latitudeNext;
	// North / South
	NSString *latitude;
	// Longitude of next waypoint.
	NSNumber *longitudeNext;
	// East / West
	NSString *longitude;
	
	// True track of waypoint.
	NSNumber *trueTrackWaypoint;
	// True track
	char trueTrack;
	// Magnetic track of waypoint
	NSNumber *magneticTrackWaypoint;
	// Magnetic track
	char magneticTrack;
	
	// Range to waypoint
	NSNumber *waypointRange;
	// unit of range to waypoint, N = nautical miles
	NSString *waypointUnit;
	
	// Waypoint name
	NSString *waypointName;
	// Checksum
	NSString *checkSum;
}

@property (nonatomic, retain) NSString *parsingString;
@property (nonatomic, assign) NSNumber *timeStamp;
@property (nonatomic, assign) NSNumber *latitudeNext;
@property (nonatomic, assign) NSNumber *longitudeNext;
@property (nonatomic, assign) NSNumber *trueTrackWaypoint;
@property (nonatomic, assign) NSNumber *magneticTrackWaypoint;
@property (nonatomic, assign) NSNumber *waypointRange;
@property (nonatomic, retain) NSString *waypointName;
@property (nonatomic, retain) NSString *waypointUnit;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *checkSum;

- (GPBWC *) initWithGPBWC:(NSString *)initString;
- (void) parseString;

@end
