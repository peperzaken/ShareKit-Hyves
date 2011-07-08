//
//  SHKHyvesTipForm.m
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

#import "SHKHyvesTipForm.h"
#import "SHK.h"
#import "SHKHyves.h"
#import "SHKHyvesTopAlignedTableViewCell.h"
#import "SHKHyvesTableViewCellWithRating.h"

#import "UITableViewCell+PMEasy.h"

@implementation SHKHyvesTipForm

@synthesize titleTextField = _titleTextField;
@synthesize bodyTextView = _bodyTextView;
@synthesize delegate = _delegate;
@synthesize rating = _rating;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {

		_titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 25)];
		_titleTextField.font = [UIFont systemFontOfSize:16.0f];
		_titleTextField.autocorrectionType = UITextAutocorrectionTypeNo;
		_titleTextField.placeholder = @"Titel";
		_titleTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		_bodyTextView = [[UITextView alloc] initWithFrame:CGRectMake(97, 5, 200, (self.view.frame.size.height - 68.0f))];
		_bodyTextView.font = [UIFont systemFontOfSize:16.0f];
		_bodyTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_bodyTextView.autocorrectionType = UITextAutocorrectionTypeNo;
		_bodyTextView.backgroundColor = [UIColor clearColor];
		
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																							  target:self
																							  action:@selector(cancel)];
		
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:SHKLocalizedString(@"Send")
																				  style:UIBarButtonItemStyleDone
																				 target:self
																				 action:@selector(save)];
		
		// init rating cell		
		_ratingCell = [[SHKHyvesTableViewCellWithRating cellForTableView:self.tableView style:UITableViewCellStyleValue2] retain];
		[_ratingCell setDelegate:self];
		[_ratingCell.detailTextLabel setText:@"Rating"];
		[_ratingCell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
		[_ratingCell.detailTextLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[_ratingCell setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		[_titleTextField becomeFirstResponder];
	}
    return self;


}

-(void)setRating:(NSUInteger)rating {

	_rating = rating;
	[_ratingCell setRating:rating];
	
}

- (void)cancel
{	
	[[SHK currentHelper] hideCurrentViewControllerAnimated:YES];
}

-(void) didChangeRatingWithRating:(NSUInteger)rating {

	_rating = rating;
	
}

- (void)save
{	
	// rating not 0?
	if ( !( _rating > 0 && _rating < 6 ) ) {
	
		[[[[UIAlertView alloc] initWithTitle:SHKLocalizedString(@"No rating given")
									 message:SHKLocalizedString(@"Please select your rating for this Tip.")
									delegate:nil
						   cancelButtonTitle:SHKLocalizedString(@"Close")
						   otherButtonTitles:nil] autorelease] show];
		return;
		
	}
		
	// no title?
	if ( !_titleTextField.text || [_titleTextField.text isEqualToString:@""] ) {
		
		[[[[UIAlertView alloc] initWithTitle:SHKLocalizedString(@"No title given")
									 message:SHKLocalizedString(@"Please enter a title for this Tip.")
									delegate:nil
						   cancelButtonTitle:SHKLocalizedString(@"Close")
						   otherButtonTitles:nil] autorelease] show];
		return;
		
		
	}
	
	// no desc..
	if ( ! _bodyTextView.text || [_bodyTextView.text isEqualToString:@""] ) {
		
		[[[[UIAlertView alloc] initWithTitle:SHKLocalizedString(@"No message given")
									 message:SHKLocalizedString(@"Please enter a message for this Tip.")
									delegate:nil
						   cancelButtonTitle:SHKLocalizedString(@"Close")
						   otherButtonTitles:nil] autorelease] show];
		return;
		
		
	}	
	
	// send
	
	//TODO: the actual protocol is not being used, but the delegate is used as pointer to the SHKHyves instance
	
	if([_delegate respondsToSelector:@selector(sendForm:body:rating:)]) {
		[_delegate sendForm:_titleTextField.text body:_bodyTextView.text rating:_rating];	
	}
	
	[[SHK currentHelper] hideCurrentViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/*
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {

	return 20.0f;
	
}
*/

/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

	static UIView * footerView = nil;
	if ( footerView == nil ) {
		
		footerView = [[UIView alloc] init];
		[footerView setBackgroundColor:[UIColor clearColor]];
		
		UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 25)];
		textLabel.textAlignment = UITextAlignmentCenter;
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.text = @"FOoter tekst";
		textLabel.font = [UIFont systemFontOfSize:13.0f];
		[footerView addSubview:textLabel];
		[textLabel release];
	}
	
	return footerView;
	
}
 */

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
	
	switch ( indexPath.row ) {
	
		case 0: case 1:
			return 44.0f;
		case 2:
			return (self.view.frame.size.height - 68.0f);
			
	}
	
	return 44.0f;
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// rating cell?
	if ( indexPath.row == 0 ) return _ratingCell;
	
	SHKHyvesTopAlignedTableViewCell* cell = [SHKHyvesTopAlignedTableViewCell cellForTableView:tableView style:UITableViewCellStyleDefault];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
    // Configure the cell...
    switch  (indexPath.row ) {
				
		case 1:
			cell.keyLabel.text = @"Titel";
			cell.keyLabel.textColor = [UIColor lightGrayColor];
			cell.keyLabel.font = [UIFont systemFontOfSize:16.0f];
			[cell.contentView addSubview:_titleTextField];
			break;
		case 2:
			cell.keyLabel.text = @"Bericht";
			//cell.detailTextLabel.frame = CGRectMake(10.0f, 10.0f, cell.detailTextLabel.frame.size.width, cell.detailTextLabel.frame.size.height);
			cell.keyLabel.textColor = [UIColor lightGrayColor];
			cell.keyLabel.font = [UIFont systemFontOfSize:16.0f];
			[cell.contentView addSubview:_bodyTextView];
			break;
			
	}
	
	return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[_titleTextField release];
	[_bodyTextView release];
	_ratingCell.delegate = nil;
	[_ratingCell release];
    [super dealloc];
}


@end

