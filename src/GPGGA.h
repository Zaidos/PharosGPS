//
//  GPGGA.h
//  Pharos
//
//  Created by Zaidos on 12/20/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GPGGA : NSObject {
	
	// Parsing string.
	NSString *parsingString;
	
	// Sentence description.
	NSString *description;
	
	// Sentence identifier
	NSString *sentenceIdentifier;
	
	// Time stamp
	NSNumber *timeStamp;
	
	// Latitude
	NSNumber *latitudeCoordinate;
	NSString *latitude;
	// Longitude
	NSNumber *longitudeCoordinate;
	NSString *longitude;
	
	// Fix Quality
	NSNumber *fix;
	
	// Number of satellites
	NSNumber *satellitesInView;
	
	// Horizontal Dilution of Precision
	// Relative accuracy of horizontal position
	NSNumber *hdop;
	
	// Altitude
	NSNumber *altitude;
	NSString *altitudeUnit;
	NSNumber *geoID;
	NSString *geoIDUnit;
	
	// Age in seconds since last update
	NSNumber *dgpsUpdateTime;
	NSNumber *referenceStationID;
}

@property (nonatomic, retain) NSString *parsingString;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *sentenceIdentifier;
@property (nonatomic, assign) NSNumber *timeStamp;
@property (nonatomic, assign) NSNumber *latitudeCoordinate;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, assign) NSNumber *longitudeCoordinate;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, assign) NSNumber *fix;
@property (nonatomic, assign) NSNumber *satellitesInView;
@property (nonatomic, assign) NSNumber *hdop;
@property (nonatomic, assign) NSNumber *altitude;
@property (nonatomic, retain) NSString *altitudeUnit;
@property (nonatomic, assign) NSNumber *geoID;
@property (nonatomic, retain) NSString *geoIDUnit;
@property (nonatomic, assign) NSNumber *dgpsUpdateTime;
@property (nonatomic, assign) NSNumber *referencesStationID;

- (GPGGA *) initWithGPGGA:(NSString *)initString;
- (void) parseString:(NSString *)initString;
- (NSString *) getLongitude;
- (NSString *) getLatitude;

@end
