//
//  SHKHyves.m
//  ShareKit+Hyves
//
//  Created by Martijn de Haan on 9/7/10.

//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//


#import "SHKHyves.h"
#import "SHKHyvesTipForm.h"

@implementation SHKHyves


#pragma mark -
#pragma mark Configuration : Service Defination

// Enter the name of the service
+ (NSString *)sharerTitle
{
	return @"Hyves";
}


// What types of content can the action handle?

// If the action can handle URLs, uncomment this section
/*
+ (BOOL)canShareURL
{
	return YES;
}*/

// If the action can handle images, uncomment this section
/*
+ (BOOL)canShareImage
{
	return YES;
}
*/

// If the action can handle text, uncomment this section

+ (BOOL)canShareText
{
	return YES;
}

// If the action can handle files, uncomment this section
/*
+ (BOOL)canShareFile
{
	return YES;
}
*/


// Does the service require a login?  If for some reason it does NOT, uncomment this section:
/*
+ (BOOL)requiresAuthentication
{
	return NO;
}
*/ 


#pragma mark -
#pragma mark Configuration : Dynamic Enable

// Subclass if you need to dynamically enable/disable the service.  (For example if it only works with specific hardware)
+ (BOOL)canShare
{
	return YES;
}



#pragma mark -
#pragma mark Authentication

// These defines should be renamed (to match your service name).
// They will eventually be moved to SHKConfig so the user can modify them.
#define SHKHyvesCallbackUrl @"http://callback"

- (id)init
{
	if((self = [super init])) {		
		self.consumerKey = SHKHyvesConsumerKey;		
		self.secretKey = SHKHyvesSecretKey;
 		self.authorizeCallbackURL = [NSURL URLWithString:SHKHyvesCallbackUrl];
		
		if([self.consumerKey isEqualToString:@"CONSUMER_KEY_HERE"] || [self.secretKey isEqualToString:@"SECRET_KEY_HERE"]) {
			NSLog(@"*** WARNING: No consumer and/or secret key specified. Please fill in your Hyves keys. For more information, see the README.");
		}		
		
		// Edit these to provide the correct urls for each oauth step
	    self.requestURL = [NSURL URLWithString:@"http://data.hyves-api.nl/?strict_oauth_spec_response=true&ha_method=auth.requesttoken&ha_version=2.0&ha_format=json&methods=tips.create"];
		self.authorizeURL = [NSURL URLWithString:@"http://www.hyves.nl/mini/api/authorize/?oauth_callback=http%3A%2F%2Fcallback"];
	    self.accessURL = [NSURL URLWithString:@"http://data.hyves-api.nl/?strict_oauth_spec_response=true&ha_method=auth.accesstoken&ha_version=2.0&ha_format=json"];
				
		// Allows you to set a default signature type, uncomment only one
		self.signatureProvider = [[[OAHMAC_SHA1SignatureProvider alloc] init] autorelease];
		//self.signatureProvider = [[[OAPlaintextSignatureProvider alloc] init] autorelease];
	}	
	return self;
}

// If you need to add additional headers or parameters to the request_token request, uncomment this section:
- (void)tokenRequestModifyRequest:(OAMutableURLRequest *)oRequest
{
	[oRequest setHTTPMethod:@"GET"];
	
		// Here is an example that adds the user's callback to the request headers
	//[oRequest setOAuthParameterName:@"oauth_callback" withValue:authorizeCallbackURL.absoluteString];

}

// If you need to add additional headers or parameters to the access_token request, uncomment this section:
- (void)tokenAccessModifyRequest:(OAMutableURLRequest *)oRequest
{
	[oRequest setHTTPMethod:@"GET"];
		
	// Here is an example that adds the oauth_verifier value received from the authorize call.
	// authorizeResponseQueryVars is a dictionary that contains the variables sent to the callback url
//	[oRequest setOAuthParameterName:@"oauth_verifier" withValue:[authorizeResponseQueryVars objectForKey:@"oauth_verifier"]];
}


#pragma mark -
#pragma mark Share Form

// If your action has options or additional information it needs to get from the user,
// use this to create the form that is presented to user upon sharing.
/*
- (NSArray *)shareFormFieldsForType:(SHKShareType)type
{
	// See http://getsharekit.com/docs/#forms for documentation on creating forms
	
	if (type == SHKShareTypeURL)
	{
		// An example form that has a single text field to let the user edit the share item's title
		return [NSArray arrayWithObjects:
				[SHKFormFieldSettings label:@"Title" key:@"title" type:SHKFormFieldTypeText start:item.title],
				nil];
	}
	
	else if (type == SHKShareTypeImage)
	{
		// return a form if required when sharing an image
		return nil;		
	}
	
	else if (type == SHKShareTypeText)
	{
		// return a form if required when sharing text
		return nil;		
	}
	
	else if (type == SHKShareTypeFile)
	{
		// return a form if required when sharing a file
		return nil;		
	}
	
	return nil;
}
*/

// If you have a share form the user will have the option to skip it in the future.
// If your form has required information and should never be skipped, uncomment this section.
/*
+ (BOOL)canAutoShare
{
	return NO;
}
*/

// Validate the user input on the share form
- (void)shareFormValidate:(SHKCustomFormController *)form
{	
	/*
	 
	 Services should subclass this if they need to validate any data before sending.
	 You can get a dictionary of the field values from [form formValues]
	 
	 --
	 
	 You should perform one of the following actions:
	 
	 1.	Save the form - If everything is correct call [form saveForm]
	 
	 2.	Display an error - If the user input was incorrect, display an error to the user and tell them what to do to fix it
	 
	 
	 */	
	
	// default does no checking and proceeds to share
	[form saveForm];
}



#pragma mark -
#pragma mark Implementation

// When an attempt is made to share the item, verify that it has everything it needs, otherwise display the share form
/*
- (BOOL)validateItem
{ 
	// The super class will verify that:
	// -if sharing a url	: item.url != nil
	// -if sharing an image : item.image != nil
	// -if sharing text		: item.text != nil
	// -if sharing a file	: item.data != nil
 
	return [super validateItem];
}
*/

// Send the share item to the server
- (BOOL)send
{	
	if (![self validateItem])
		return NO;
	
	/*
	 Enter the necessary logic to share the item here.
	 
	 The shared item and relevant data is in self.item
	 // See http://getsharekit.com/docs/#sending
	 
	 --
	 
	 A common implementation looks like:
	 	 
	 -  Send a request to the server
	 -  call [self sendDidStart] after you start your action
	 -	after the action completes, fails or is cancelled, call one of these on 'self':
		- (void)sendDidFinish (if successful)
		- (void)sendDidFailShouldRelogin (if failed because the user's current credentials are out of date)
		- (void)sendDidFailWithError:(NSError *)error shouldRelogin:(BOOL)shouldRelogin
		- (void)sendDidCancel
	 */ 
	
	
	// Here is an example.  
	// This example is for a service that can share a URL
	
	 
	// Determine which type of share to do
	if (item.shareType == SHKShareTypeText) // sharing a URL
	{
		
		[self showTipForm];
		return NO;
		
		// For more information on OAMutableURLRequest see http://code.google.com/p/oauthconsumer/wiki/UsingOAuthConsumer
	
	}
	
	return NO;
	
}

-(void)sendForm:(NSString *)title body:(NSString *)body rating:(NSUInteger)rate {
	
	
	OAMutableURLRequest *oRequest = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://data.hyves-api.nl/"]
																	consumer:consumer // this is a consumer object already made available to us
																	   token:accessToken // this is our accessToken already made available to us
																	   realm:nil
														   signatureProvider:signatureProvider];
	
	// Set the http method (POST or GET)
	[oRequest setHTTPMethod:@"POST"];
		
	OARequestParameter *titleParam = [[OARequestParameter alloc] initWithName:@"title"
																		value:title];
	OARequestParameter *bodyParam = [[OARequestParameter alloc] initWithName:@"body"
																	   value:body];
	
	OARequestParameter *tipCat = [[OARequestParameter alloc] initWithName:@"tipcategoryid"
																	value:SHKEncode(@"00be7fa4a7eb16282922bb1236a139cfe3")];
	
	OARequestParameter *rating = [[OARequestParameter alloc] initWithName:@"rating"
																	value:SHKEncode([NSString stringWithFormat:@"%u", rate])];
	
	OARequestParameter * ha_method = [[OARequestParameter alloc] initWithName:@"ha_method"
																		value:SHKEncode(@"tips.create")];
	
	OARequestParameter * ha_version = [[OARequestParameter alloc] initWithName:@"ha_version"
																		 value:SHKEncode(@"2.0")];
	
	OARequestParameter * ha_format = [[OARequestParameter alloc] initWithName:@"ha_format"
																		value:SHKEncode(@"json")];
	
	OARequestParameter * ha_fancylayout = [[OARequestParameter alloc] initWithName:@"ha_fancylayout"
																			 value:SHKEncode(@"false")];
	
	
	
	
	// Add the params to the request
	[oRequest setParameters:[NSArray arrayWithObjects:titleParam, bodyParam, tipCat, rating, ha_method, ha_version, ha_format, ha_fancylayout, nil]];
	[bodyParam release];
	[titleParam release];
	[tipCat release];
	[rating release];
	[ha_method release];
	[ha_version release];
	[ha_format release];
	[ha_fancylayout release];
	
	// Start the request
	OAAsynchronousDataFetcher *fetcher = [OAAsynchronousDataFetcher asynchronousFetcherWithRequest:oRequest
																						  delegate:self
																				 didFinishSelector:@selector(sendTicket:didFinishWithData:)
																				   didFailSelector:@selector(sendTicket:didFailWithError:)];	
	
	[fetcher start];
	[oRequest release];
	
	// Notify delegate
	[self sendDidStart];	
	
}

-(void)showTipForm {
	
	SHKHyvesTipForm * rootView = [[SHKHyvesTipForm alloc] initWithStyle:UITableViewStylePlain];
	
	// force view to load so we can set textView text
	
	[rootView view];
	
	//TODO: not really best practice to transfer a relation like this
	//use 
	rootView.delegate = self;
	rootView.bodyTextView.text = item.text;
	rootView.titleTextField.text = item.title;

	// has rating?
	if ( [item customValueForKey:@"rating"] )
		[rootView setRating:[[item customValueForKey:@"rating"] integerValue]];
	
	[self pushViewController:rootView animated:NO];
	
	[[SHK currentHelper] showViewController:self];	
	
}


// This is a continuation of the example provided in 'send' above.  It handles the OAAsynchronousDataFetcher response
// This is not a required method and is only provided as an example
- (void)sendTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data 
{	
	if (ticket.didSucceed)
	{
		// The send was successful
		[self sendDidFinish];
	}
	
	else 
	{
		// Handle the error
		
		// If the error was the result of the user no longer being authenticated, you can reprompt
		// for the login information with:
		// [self sendDidFailShouldRelogin];
		
		NSLog(@"Error");
		NSLog(@"%@", [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
		
		NSString *string = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];		
		
		// in case our makeshift parsing does not yield an error message
		NSString *errorMessage = @"Unknown Error";		
		
		NSScanner *scanner = [NSScanner scannerWithString:string];
		
		// skip until error message
		[scanner scanUpToString:@"\"error_message\":\"" intoString:nil];
		
		
		if ([scanner scanString:@"\"error_message\":\"" intoString:nil])
		{
			// get the message until the closing double quotes
			[scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&errorMessage];
		}
		
		
		//if error_message is "OAuth token is invalid."
		if([errorMessage isEqualToString:@"OAuth token is invalid."]) {
			[self sendDidFailShouldRelogin];
		}
		else {
			// Otherwise, all other errors should end with:
			[self sendDidFailWithError:[SHK error:@"Er is een fout opgetreden tijdens het posten van de Tip. Probeer het opnieuw a.u.b."] shouldRelogin:NO];
		}
	}
}
- (void)sendTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error
{
	[self sendDidFailWithError:error shouldRelogin:NO];
}

@end
