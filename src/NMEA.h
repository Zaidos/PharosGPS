//
//  NMEA.h
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GPGGA.h"
#import "Map.h"

@interface NMEA : NSObject {
	GPGGA *currentGPGGA;
	NSMutableString *bufferString;
	
	Map *mapView;
}

@property (nonatomic, retain) GPGGA *currentGPGGA;
@property (nonatomic, retain) NSMutableString *bufferString;

- (NMEA *) initWithMap:(Map *)newMap;

- (void) parseString:(NSString *)stringToParse;

- (NSString *)parseData:(NSString *)rawData;
- (BOOL) validateChecksum:(NSString *)sentence;

@end
