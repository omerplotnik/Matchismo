//
//  SetCardView.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 17/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation SetCardView

#pragma mark - Properties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}


- (void)setColor:(NSString *)color
{
  _color = color;
  [self setNeedsDisplay];
}

- (void)setShading:(CGFloat)shading
{
  _shading = shading;
  [self setNeedsDisplay];
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

#pragma mark - Gesture Handling


#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  if (self.isChosen) {
    
    [[UIColor blueColor] setStroke];
    roundedRect.lineWidth = 8;
    [roundedRect stroke];
  }
    [roundedRect stroke];
    CGContextRestoreGState(context);
  
  [self setShapeColor];
  [self drawShpes];
}


- (void)drawShpes {
  if ([self.suit isEqualToString:@"●"])
  {
    [self drawOvals];
  } else if ([self.suit isEqualToString:@"◼︎"])
  {
    [self drawDiamonds];
  } else {
    [self drawSquiggles];
  }
}

- (void)setShapeColor
{
  if ([self.color isEqualToString:@"red"]) {
    [[UIColor redColor] setFill];
    [[UIColor redColor] setStroke];
  } else if ([self.color isEqualToString:@"green"]) {
    [[UIColor greenColor] setFill];
    [[UIColor greenColor] setStroke];
  } else if ([self.color isEqualToString:@"purple"]) {
    [[UIColor purpleColor] setFill];
    [[UIColor purpleColor] setStroke];
  }
}

 //   }

- (void)drawOvals
{
  if (self.rank == 1)
  {
    [self drawOvalAtPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)];
  } else if (self.rank == 2) {
    [self drawOvalAtPoint:CGPointMake(self.bounds.size.width / 3.0, self.bounds.size.height / 2.0)];
    [self drawOvalAtPoint:CGPointMake(self.bounds.size.width / 3.0 * 2, self.bounds.size.height / 2.0)];
  }  else {
    [self drawOvalAtPoint:CGPointMake(self.bounds.size.width / 5.0 * 1, self.bounds.size.height / 2.0)];
    [self drawOvalAtPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)];
    [self drawOvalAtPoint:CGPointMake(self.bounds.size.width / 5.0 * 4, self.bounds.size.height / 2.0)];
  }
}

- (void)drawDiamonds
{
  if (self.rank == 1)
  {
    [self drawDiamondAtPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)];
  } else if (self.rank == 2) {
    [self drawDiamondAtPoint:CGPointMake(self.bounds.size.width / 3.0, self.bounds.size.height / 2.0)];
    [self drawDiamondAtPoint:CGPointMake(self.bounds.size.width / 3.0 * 2, self.bounds.size.height / 2.0)];
  }  else {
    [self drawDiamondAtPoint:CGPointMake(self.bounds.size.width / 5.0 * 1, self.bounds.size.height / 2.0)];
    [self drawDiamondAtPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)];
    [self drawDiamondAtPoint:CGPointMake(self.bounds.size.width / 5.0 * 4, self.bounds.size.height / 2.0)];
  }
}

-(void)drawSquiggles
{
  if (self.rank == 1)
  {
    [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)];
  } else if (self.rank == 2) {
    [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width / 3.0, self.bounds.size.height / 2.0)];
    [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width / 3.0 * 2, self.bounds.size.height / 2.0)];
  }  else {
    [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width / 5.0 * 1, self.bounds.size.height / 2.0)];
    [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)];
    [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width / 5.0 * 4, self.bounds.size.height / 2.0)];
  }
}



#pragma mark - Shapes

//- (void)drawShapes
//{
  
//}


#define SQUIGGLE_WIDTH 0.12
#define SQUIGGLE_HEIGHT 0.3
#define SQUIGGLE_FACTOR 0.8
#define SYMBOL_LINE_WIDTH 0.03
 
- (void)drawSquiggleAtPoint:(CGPoint)point {
  CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
  CGFloat dsqx = dx * SQUIGGLE_FACTOR;
  CGFloat dsqy = dy * SQUIGGLE_FACTOR;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
  [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
               controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
  [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
          controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
          controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
  [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
               controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
  [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
          controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
          controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
  [path closePath];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
  [self shadePath:path];
  [path stroke];
}

#define DIAMOND_WIDTH 0.4
#define DIAMOND_HEIGHT 0.4
#define SYMBOL_LINE_WIDTH 0.03
 
- (void)drawDiamondAtPoint:(CGPoint)point {
  CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH ;
  CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT ;

  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x, point.y - dy)];
  [path addLineToPoint:CGPointMake(point.x + dx, point.y)];
  [path addLineToPoint:CGPointMake(point.x,point.y + dy)];
  [path addLineToPoint:CGPointMake(point.x - dx, point.y)];
  [path addLineToPoint:CGPointMake(point.x, point.y - dy)];
  [path closePath];

  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
  [self shadePath:path];
  [path stroke];
}


#define OVAL_WIDTH 0.25
#define OVAL_HEIGHT 0.6
#define SYMBOL_LINE_WIDTH 0.03
 
- (void)drawOvalAtPoint:(CGPoint)point {
  CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH ;
  CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT ;

  
  UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x - dx, point.y - dy, self.bounds.size.width *OVAL_WIDTH, self.bounds.size.height *OVAL_HEIGHT)];
  [path closePath];

  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
  [self shadePath:path];
  [path stroke];
}


- (void)shadePath:(UIBezierPath *)path {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  [path addClip];
  if (self.shading == 1) {
    [path fill];
  } else if (self.shading == 0.5) {
    UIBezierPath* stripes = [[UIBezierPath alloc] init];
    
    for (CGFloat x = 0; x < path.bounds.size.width; x = x + 5) {
      [stripes moveToPoint:CGPointMake(path.bounds.origin.x + x, path.bounds.origin.y)];
      [stripes addLineToPoint:CGPointMake(path.bounds.origin.x + x + 5, path.bounds.origin.y + path.bounds.size.height)];
    }
    stripes.lineWidth = 2;
    
    [stripes stroke];
  }
  CGContextRestoreGState(context);
}



#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
