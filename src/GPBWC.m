//
//  GPBWC.m
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import "GPBWC.h"

@implementation GPBWC

@synthesize parsingString;
@synthesize timeStamp;
@synthesize latitudeNext;
@synthesize longitudeNext;
@synthesize longitude;
@synthesize latitude;
@synthesize trueTrackWaypoint;
@synthesize magneticTrackWaypoint;
@synthesize waypointName;
@synthesize waypointRange;
@synthesize waypointUnit;
@synthesize checkSum;

- (GPBWC *) initWithGPBWC:(NSString *)initString {
	
	parsingString = initString;
	description = @"Bearing and distance to waypoint, great circle";
	sentenceIdentifier = @"$GPBWC";
	trueTrack = 'T';
	magneticTrack = 'M';
	
	[super init];
	
	return self;
}

- (void) parseString {
	
	NSArray *words = [parsingString componentsSeparatedByString:@","];
	
	timeStamp = [words objectAtIndex:1];
	latitudeNext = [words objectAtIndex:2];
	latitude = [words objectAtIndex:3];
	longitudeNext = [words objectAtIndex:4];
	longitude = [words objectAtIndex:5];
	trueTrackWaypoint = [words objectAtIndex:6];
	magneticTrackWaypoint = [words objectAtIndex:8];
	waypointRange = [words objectAtIndex:10];
	waypointUnit = [words objectAtIndex:11];
	
	NSArray *checkSumString = [[words objectAtIndex:12] componentsSeparatedByString:@"*"];
	waypointName = [checkSumString objectAtIndex:0];
	checkSum = [checkSumString objectAtIndex:1];
}

- (void) dealloc {
	[super dealloc];
}

@end
