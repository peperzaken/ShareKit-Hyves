//
//  SHKHyvesTableViewCellWithRating.m
//  ShareKit+Hyves
//
//  Created by Martijn de Haan on 1/6/10.

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

#import "SHKHyvesTableViewCellWithRating.h"
#import "SHKHyvesStarView.h"

@implementation SHKHyvesTableViewCellWithRating

@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
		_delegate = nil;
		
		// create star view
		_starView = [[SHKHyvesStarView alloc] initWithFrame:CGRectMake(100, 7, 140, 30)];
		[_starView setDelegate:self];
		[self addSubview:_starView];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
	self.detailTextLabel.frame = CGRectMake(16.0f, 10.0f, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
	
	[super layoutSubviews];
}

-(void) didChangeRatingWithRating:(NSUInteger)rating {

	
	// to delegate
	if ( _delegate != nil && [(NSObject *)_delegate respondsToSelector:@selector(didChangeRatingWithRating:)] )
		[_delegate didChangeRatingWithRating:rating];	
}

-(void)setRating:(NSUInteger)rating {

	[_starView setActiveStars:rating];
}

- (void)dealloc {

	[_starView release];
	[_delegate release];
	_delegate = nil;
    [super dealloc];
}


@end
