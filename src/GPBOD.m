//
//  GPBOD.m
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import "GPBOD.h"

@implementation GPBOD

@synthesize parsingString;
@synthesize bearingDegreesTrue;
@synthesize bearingDegreesMagnetic;
@synthesize destination;
@synthesize start;

- (GPBOD *) initWithGPBOD:(NSString *)initString {
	
	parsingString = initString;
	description = @"Bearing Origin to Destination";
	sentenceIdentifier = @"$GPBOD";
	bearingTrue = 'T';
	bearingMagnetic = 'M';
	
	[super init];
	
	return self;
}

- (void) parseString {
	
	NSArray *words = [parsingString componentsSeparatedByString:@","];
	
	bearingDegreesTrue = [words objectAtIndex:1];
	bearingDegreesMagnetic = [words objectAtIndex:3];
	destination = [words objectAtIndex:4];
	start = [words objectAtIndex:5];
} 

- (void) dealloc {	
	[super dealloc];
}

@end
