//
//  GPGGA.m
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import "GPGGA.h"


@implementation GPGGA

@synthesize parsingString;
@synthesize description;
@synthesize sentenceIdentifier;
@synthesize timeStamp;
@synthesize latitudeCoordinate;
@synthesize latitude;
@synthesize longitudeCoordinate;
@synthesize longitude;
@synthesize fix;
@synthesize satellitesInView;
@synthesize hdop;
@synthesize altitude;
@synthesize altitudeUnit;
@synthesize geoID;
@synthesize geoIDUnit;
@synthesize dgpsUpdateTime;
@synthesize referencesStationID;

- (GPGGA *) initWithGPGGA:(NSString *)initString {
	
	parsingString = initString;
	[self parseString:initString];
	
	description = @"Global Positioning System Fix Data";
	sentenceIdentifier = @"$GPGGA";
	
	[super init];
	
	return self;
}

- (void) parseString:(NSString *)initString {
	
	parsingString = initString;
	
	NSArray *words = [parsingString componentsSeparatedByString:@","];
	
	timeStamp = [words objectAtIndex:1];
	latitudeCoordinate = [words objectAtIndex:2];
	latitude = [words objectAtIndex:3];
	longitudeCoordinate = [words objectAtIndex:4];
	longitude = [words objectAtIndex:5];
	fix = [words objectAtIndex:6];
	satellitesInView = [words objectAtIndex:7];
	hdop = [words objectAtIndex:8];
	altitude = [words objectAtIndex:9];
	altitudeUnit = [words objectAtIndex:10];
	geoID =[words objectAtIndex:11];
	geoIDUnit = [words objectAtIndex:12];
	dgpsUpdateTime = [words objectAtIndex:13];
	referenceStationID = [words objectAtIndex:14];
}

- (NSString *) getLongitude {
	if ([longitudeCoordinate intValue] > 0) {
		
		NSString *newLocation = longitudeCoordinate;
		
		NSLog(@"%@", newLocation);

		int period = [newLocation rangeOfString:@"."].location;
		
		int degrees = [[newLocation 
						substringWithRange:NSMakeRange(0, (period-2))]
					   intValue];

		int minutes = [[newLocation 
					   substringWithRange:NSMakeRange((period-2), (period-3))] 
					   intValue];

		NSString *seconds = [newLocation substringFromIndex:(period +1)];
		NSString *sl = [seconds substringToIndex:2];
		NSString *sr = [seconds substringFromIndex:2];
		
		double sec = [[NSString stringWithFormat:@"%@.%@", sl, sr] doubleValue];
				
		if ([longitude isEqualToString:@"W"]) {
			return [NSString stringWithFormat:@"-%@d.@f@f", degrees, ( minutes / 60 ), ( sec / 3600 )];
		}
		else {
			return [NSString stringWithFormat:@"%@d.@f@f", degrees, (minutes/60), (sec/3600)];
		}
	}
	else {
		return @"0";
	}
}
- (NSString *) getLatitude {
	if ([latitudeCoordinate intValue] > 0) {
		
		NSString *newLocation = latitudeCoordinate;
		
		NSLog(@"%@", newLocation);
		
		int period = [newLocation rangeOfString:@"."].location;
		
		int degrees = [[newLocation 
						substringWithRange:NSMakeRange(0, (period-2))]
					   intValue];
		
		int minutes = [[newLocation 
						substringWithRange:NSMakeRange((period-2), (period-3))] 
					   intValue];
		
		NSString *seconds = [newLocation substringFromIndex:(period +1)];
		NSString *sl = [seconds substringToIndex:2];
		NSString *sr = [seconds substringFromIndex:2];
		
		double sec = [[NSString stringWithFormat:@"%@.%@", sl, sr] doubleValue];
		
		//double newCoord = degrees + (minutes / 60) + (sec / 3600);
		
		if ([longitude isEqualToString:@"W"]) {
			return [NSString stringWithFormat:@"-%@d.@f@f", degrees, (minutes/60), (sec/3600)];
		}
		else {
			return [NSString stringWithFormat:@"%@d.@f@f", degrees, (minutes/60), (sec/3600)];
		}
	}
	else {
		return @"0";
	}
	
}



- (void) dealloc {
	[super dealloc];
}


// OLD FORMULAS DO NOT USE.
//
//- (NSString *) getLongitude {
//	if ([longitudeCoordinate intValue] > 0) {
//		
//		NSString *newLocation = longitudeCoordinate;
//		
//		NSLog(@"%@", newLocation);
//		
//		int period = [newLocation rangeOfString:@"."].location;
//		
//		NSString *degrees = [newLocation substringWithRange:NSMakeRange(0, (period-2))];
//		NSString *minutes = [newLocation substringWithRange:NSMakeRange((period-2), (period-3))];
//		
//		NSString *minRight = [newLocation substringFromIndex:(period+1)];
//		int newRight = ([minRight intValue] * 60);
//		NSString *seconds = [NSString stringWithFormat:@"%d", newRight];
//		
//		NSLog(@"%@.%@%@", degrees, minutes, seconds);
//		
//		if ([longitude isEqualToString:@"W"]) {
//			return [NSString stringWithFormat:@"-%@.%@%@", degrees, minutes, seconds];
//		}
//		else {
//			return [NSString stringWithFormat:@"%@.%@%@", degrees, minutes, seconds];
//		}
//	}
//	else {
//		return @"0";
//	}
//}
//- (NSString *) getLatitude {
//	if ([latitudeCoordinate intValue] > 0) {
//		
//		NSString *newLocation = latitudeCoordinate;
//		
//		NSLog(@"%@", newLocation);
//		
//		int period = [newLocation rangeOfString:@"."].location;
//		
//		NSString *minutes = [newLocation substringWithRange:NSMakeRange((period-2), (period-3))];
//		NSString *degrees = [newLocation substringWithRange:NSMakeRange(0, (period-2))];
//		
//		NSString *minRight = [newLocation substringFromIndex:(period+1)];
//		int newRight = ([minRight intValue] * 60);
//		NSString *seconds = [NSString stringWithFormat:@"%d", newRight];
//		
//		NSLog(@"%@.%@%@", degrees, minutes, seconds);
//		
//		if ([latitude isEqualToString:@"S"]) {
//			return [NSString stringWithFormat:@"-%@.%@%@", degrees, minutes, seconds];
//		}
//		else {
//			return [NSString stringWithFormat:@"%@.%@%@", degrees, minutes, seconds];
//		}
//	}
//	else {
//		return @"0";
//	}
//}
//

@end
