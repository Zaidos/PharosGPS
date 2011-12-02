//
//  PharosAppDelegate.m
//  Pharos
//
//  Created by Zaidos on 12/19/10.
//  Copyright 2010 CSUB. All rights reserved.
//

#import "PharosAppDelegate.h"
#import "Map.h"

@implementation PharosAppDelegate

@synthesize window;
@synthesize textFieldResults;
@synthesize textView;

@synthesize buttonDiscover;
@synthesize buttonConnect;
@synthesize buttonStop;

@synthesize pairingController;
@synthesize pharosDevice;
@synthesize channel;

@synthesize mapView;
@synthesize nmea;

// Startup shit.
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	pairingController = [[IOBluetoothPairingController alloc] init];
	
	displayResults = [[NSMutableString alloc] 
					  initWithString:@"Application loaded.\n"];
	
	[textFieldResults setStringValue:displayResults];
	
	mapView = [[Map alloc] init];
	nmea = [[NMEA alloc] initWithMap:mapView];
}

// Deallocator.
- (void)dealloc {
	[channel closeChannel];
	[[channel getDevice] closeConnection];
	
	[mapView release];
	mapView = nil;

	[displayResults release];
	displayResults = nil;
	[textFieldResults release];
	textFieldResults = nil;
	[buttonDiscover release];
	buttonDiscover = nil;
	[buttonConnect release];
	buttonConnect = nil;
	[buttonStop release];
	buttonStop = nil;
	[window release];
	window = nil;
	[channel release];
	channel = nil;
	[pharosDevice release];
	pharosDevice = nil;
	[pairingController release];
	pairingController = nil;
	[super dealloc];
}

// Launches the device dialog.
- (void)performClick:(id)sender {
	
	// Launch device selector.
	int success = [pairingController runModal];
	
	// If device has been selected!
	if (success == kIOBluetoothUISuccess) {		
		NSArray *returnedDevices = [pairingController getResults];
		
		for(IOBluetoothDevice *dev in returnedDevices) {
			
			if ([[dev name] isEqualToString:@"Pharos iGPS-BT"]) {
				pharosDevice = dev;
			}
			
			[displayResults appendFormat:@"Name: %@ \n",[dev name]];
			[displayResults appendFormat:@"Address: %@ \n", [dev getAddressString]];
		}
		
		
		[buttonDiscover setEnabled:NO];
		[buttonConnect setEnabled:YES];
		[textFieldResults setStringValue:displayResults];
		
	}
	else if (success == kIOBluetoothUIUserCanceledErr) {
		[displayResults appendString:@"User has cancelled the selection."];
	}
	else {
		[displayResults appendString:@"There was an unexpected error. Uh oh!"];
	}
}

// Begins gathering data.
- (void)connectClick:(id)sender {
	[IOBluetoothDevice registerForConnectNotifications:self	
											  selector:@selector(newConnection:fromDevice:)];
	[pharosDevice openConnection];
}

// Closes channels and data connections.
- (void)stopClick:(id)sender {
	[displayResults release];
	displayResults = nil;
	displayResults = [[NSMutableString alloc] init];
	
	[channel closeChannel];
	[[channel getDevice] closeConnection];
}

- (void)mapClick:(id)sender {
	[NSBundle loadNibNamed:@"Map" owner:mapView];	
}

// Starts a new data connection to the device.
- (void)newConnection:(IOBluetoothUserNotification *)notification 
		   fromDevice:(IOBluetoothDevice *)device {
	
	[displayResults appendFormat:@"Connecting to %@. \n", [device name]];
	[textFieldResults setStringValue:displayResults];
	
	[buttonStop setEnabled:YES];
	
	IOReturn ret;
	NSArray *returnedServices = [device getServices];
	
	BluetoothRFCOMMChannelID rfcommChannelID;
	
	for (IOBluetoothSDPServiceRecord* service in returnedServices) {
		
		ret = [service getRFCOMMChannelID:&rfcommChannelID];
		
		if (ret == kIOReturnSuccess) {
			
			break;
		}
	}
	
	[device openRFCOMMChannelAsync:&channel 
					 withChannelID:rfcommChannelID
						  delegate:self];
	
	[NSBundle loadNibNamed:@"Map" owner:mapView];	

}

// Raw data input handler.
- (void)rfcommChannelData:(IOBluetoothRFCOMMChannel*)rfcommChannel
					 data:(void *)dataPointer 
				   length:(size_t)dataLength {
	
	// Raw data from GPS device.
	NSData *data = [NSData dataWithBytes:dataPointer 
								  length:dataLength];
	
	// Data converted to a string.
	NSString *dataString = [[NSString alloc] initWithData:data 
												 encoding:NSUTF8StringEncoding];
		
	NSString *tmpString = [NSString stringWithFormat:@"%@", [nmea parseData:dataString]];
	
	[nmea parseString:tmpString];
	
	[dataString release];
	dataString = nil;
	
	// Add data to the text storage.
	[[[textView textStorage] mutableString] appendString:tmpString];
	
	// Auto scroll down.
	[textView scrollRangeToVisible:NSMakeRange([[textView string] length] - 1, 0)];
}

// Closes the device connection.
- (void)rfcommChannelClosed:(IOBluetoothRFCOMMChannel*)rfcommChannel {
	
	[displayResults appendFormat:@"Disconnecting from %@. \n", [pharosDevice name]];
	[textFieldResults setStringValue:displayResults];
	
	[buttonStop setEnabled:NO];
}



//- (void)rfcommChannelOpenComplete:(IOBluetoothRFCOMMChannel*)rfcommChannel 
//						   status:(IOReturn)error;
//- (void)rfcommChannelData:(IOBluetoothRFCOMMChannel*)rfcommChannel
//					 data:(void *)dataPointer length:(size_t)dataLength;
//- (void)rfcommChannelControlSignalsChanged:(IOBluetoothRFCOMMChannel*)rfcommChannel;
//- (void)rfcommChannelFlowControlChanged:(IOBluetoothRFCOMMChannel*)rfcommChannel;
//- (void)rfcommChannelWriteComplete:(IOBluetoothRFCOMMChannel*)rfcommChannel
//							refcon:(void*)refcon status:(IOReturn)error;
//- (void)rfcommChannelQueueSpaceAvailable:(IOBluetoothRFCOMMChannel*)rfcommChannel;
//

@end
