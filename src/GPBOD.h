//
//  GPBOD.h
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GPBOD : NSObject {
	
	// Parsing string.
	NSString *parsingString;
	
	// Sentence description.
	NSString *description;
	
	// Sentence identifier.
	NSString *sentenceIdentifier;
	
	// Bearing degrees TRUE from START to DEST
	NSNumber *bearingDegreesTrue;
	char bearingTrue;

	// Bearing degrees Magnetic from START to DEST
	NSNumber *bearingDegreesMagnetic;
	char bearingMagnetic;
	
	NSString *destination;
	NSString *start;
}


@property (nonatomic, retain) NSString *parsingString;
@property (nonatomic, assign) NSNumber *bearingDegreesTrue;
@property (nonatomic, assign) NSNumber *bearingDegreesMagnetic;
@property (nonatomic, retain) NSString *destination;
@property (nonatomic, retain) NSString *start;

- (GPBOD *) initWithGPBOD:(NSString *)initString;
- (void) parseString;

@end
