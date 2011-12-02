//
//  PharosAppDelegate.h
//  Pharos
//
//  Created by Zaidos on 12/19/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IOBluetooth/IOBluetooth.h>
#import <IOBluetoothUI/IOBluetoothUI.h>
#import "Map.h"
#import "GPGGA.h"
#import "NMEA.h"

@interface PharosAppDelegate : NSObject <NSApplicationDelegate> {
	
    NSWindow *window;
	
	NSButton *buttonDiscover;
	NSButton *buttonConnect;
	NSButton *buttonStop;
	
	NSTextField *textFieldResults;
	NSTextView	*textView;
	
	NSMutableString *displayResults;
	
	NMEA *nmea;
	
    // An instance of IOBluetoothDevice represents a single remote Bluetooth device.
	IOBluetoothDevice *pharosDevice;
	
	// This object displays a window in which a user can initiate 
	// pairing with a remote Bluetooth device. If necessary, 
	// this object will also prompt the user for a personal 
	// identification number (PIN) to complete the pairing process.
	IOBluetoothPairingController *pairingController;	
	
	// Connection channel.
	IOBluetoothRFCOMMChannel *channel;
	
	Map *mapView;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet NSButton *buttonDiscover;
@property (nonatomic, retain) IBOutlet NSButton *buttonConnect;
@property (nonatomic, retain) IBOutlet NSButton *buttonStop;
@property (nonatomic, retain) IBOutlet NSTextField *textFieldResults;
@property (nonatomic, retain) IBOutlet NSTextView *textView;
@property (nonatomic, retain) IOBluetoothDevice *pharosDevice;
@property (nonatomic, retain) IOBluetoothPairingController *pairingController;
@property (nonatomic, retain) IOBluetoothRFCOMMChannel *channel;
@property (nonatomic, retain) Map *mapView;
@property (nonatomic, retain) NMEA *nmea;

- (void)performClick:(id)sender;
- (void)connectClick:(id)sender;	
- (void)stopClick:(id)sender;
- (void)mapClick:(id)sender;

@end
