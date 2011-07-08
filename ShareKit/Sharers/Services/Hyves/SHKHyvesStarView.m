//
//  SHKHyvesStarView.m
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

#import "SHKHyvesStarView.h"
#import "SHKHyvesTableViewCellWithRating.h"

@implementation SHKHyvesStarView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {

        // Initialization code
		[self setBackgroundColor:[UIColor clearColor]];
		//[self setBackgroundColor:[UIColor magentaColor]];
		_delegate = nil;
		
	}
    return self;
}


- (void)drawRect:(CGRect)rect {

    // Drawing code, draw stars..
	UIImage * activeStar = [UIImage imageNamed:@"SHKHyves.bundle/images/star_on.png"];
	UIImage * inactiveStar = [UIImage imageNamed:@"SHKHyves.bundle/images/star_off.png"];
	
	for ( int i = 0; i < 5; i++ ) {
		
		if ( i < _activeStars )
			[activeStar drawInRect:CGRectMake(2+i*23, 4, 21, 20)];
		else
			[inactiveStar drawInRect:CGRectMake(2+i*23, 4, 21, 20)];
		
	}
		
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

		// get touch
		UITouch * touch = [[touches allObjects] objectAtIndex:0];
		CGPoint location = [touch locationInView:self];
			
		// log location
		int star = location.x / 23;
	
		// set active stars
		_activeStars = MIN(5, star + 1);
		
		// delegate?
		 if ( _delegate != nil && [(NSObject *)_delegate respondsToSelector:@selector(didChangeRatingWithRating:)] )
		 [_delegate didChangeRatingWithRating:_activeStars];
		
		
		
		[self setNeedsDisplay];
	
}

-(void)setActiveStars:(NSUInteger)rating {

	_activeStars = rating;
	[self setNeedsDisplay];
	
}

- (void)dealloc {
	[_delegate release];
	_delegate = nil;
    [super dealloc];
}


@end
