//
//  NMEA.m
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import "NMEA.h"


@implementation NMEA

@synthesize currentGPGGA;
@synthesize bufferString;

- (NMEA *) initWithMap:(Map *)newMap {
	
	mapView = newMap;
	bufferString = [[NSMutableString alloc] init];
	currentGPGGA = [[GPGGA alloc] 
					initWithGPGGA:@"$GPGGA,023042,0,N,0,W,0,04,2.3,507.3,M,-24.1,M,,*75"];
	
	[super init];
	
	return self;
}

- (void) parseString:(NSString *)stringToParse {
	
	NSArray *words = [stringToParse componentsSeparatedByString:@","];
		
	if ([[words objectAtIndex:0] isEqualToString:@"$GPGGA"]) {
		[currentGPGGA parseString:stringToParse];
		[mapView setCoordinates:[currentGPGGA getLongitude] 
						withLat:[currentGPGGA getLatitude]];
	}
}

- (BOOL) validateChecksum:(NSString *)sentence {
	
	int sum = 0; 
	int inx;
	char tmp;
	
	for (inx = 1; ; inx++) {
		
		if (inx >= [sentence length]) {
			
			// No checksum found
			return NO;
		}
		
		tmp = [sentence characterAtIndex:inx];
		
		// Indicates end of data and start of checksum
		if (tmp == '*') {
			break;
		}
		// Build checksum
		sum = sum ^ tmp; 
	}
	
	// Calculated checksum converted to a 2 digit hex string
	NSString *sumString = [NSString stringWithFormat:@"%02x", sum];
	// Compare to checksum in sentence
	NSRange newRange = NSMakeRange((inx+1), 2);
	return [sumString isEqualToString:[sentence substringWithRange:newRange]];
}

- (NSString *)parseData:(NSString *)rawData {
	
	int start, end;
	NSRange startRange, endRange;
	NSString *sentence;
		
	if ( rawData != nil && ([rawData length] > 0) ) {
		
		// Add new data	
		[bufferString appendString:rawData];
	}
	
	do {

		// Find start of next sentence
		startRange = [bufferString rangeOfString:@"$"];
		
		if (startRange.location == NSNotFound) {
			// No start found
			return nil;
		}
		else {
			start = startRange.location;
		}

		// Set start of string.
		NSString *startBuffer = [bufferString substringFromIndex:start];
		[bufferString setString:startBuffer];
				
		// Find end of sentence
		endRange = [bufferString rangeOfString:@"\r\n"];
				
		if (endRange.location == NSNotFound) {
			
			// No end found, wait for more data.
			return nil;
		}
		else {
			end = endRange.location;
		}
				
		sentence = [bufferString substringWithRange:NSMakeRange(0, (end+2))];
		
		NSString *tmpBuffer = [bufferString substringFromIndex:(end+2)]; 
		[bufferString setString:tmpBuffer];
		
	} while (![self validateChecksum:sentence]);
		
	// Valid sentence found.
	// Remove trailing checksum and \r\n
	sentence = [sentence substringWithRange:NSMakeRange(0, [sentence rangeOfString:@"*"].location)];
		
	// Return sentence.
	return sentence;
}

- (void) dealloc {
	[bufferString release];
	bufferString = nil;
	
	[currentGPGGA release];
	currentGPGGA = nil;
	[super dealloc];
}

@end
