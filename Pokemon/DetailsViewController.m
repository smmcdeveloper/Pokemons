//
//  DetailsViewController.m
//  Pokemon
//
//  Created by SMMC on 05/09/2021.
//

#import "DetailsViewController.h"

@import SDWebImage;

@interface DetailsViewController() <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *typesTableView;
@property (strong, nonatomic) UITableView *statsTableView;

@end

@implementation DetailsViewController

@synthesize name, imageUrl, typesTableView, statsTableView, types, stats;

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupView];
    [self addTablesView];
}

#pragma mark - Private Methods
- (void)setupView {
 
 self.view.backgroundColor = [UIColor whiteColor];

 UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
 self.navigationItem.leftBarButtonItem = backButton;
 self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
 self.navigationItem.title = self.name;

 SDAnimatedImageView *imagenView = [[SDAnimatedImageView alloc] initWithFrame:CGRectMake(0, 200, 130, 130)];
 [imagenView setContentMode: UIViewContentModeScaleAspectFill];
 imagenView.layer.borderColor = [UIColor whiteColor].CGColor;
 imagenView.layer.borderWidth = 10.0;
 imagenView.layer.cornerRadius = 50.0;
 imagenView.layer.masksToBounds = YES;
 [self.view addSubview:imagenView];
  
 if (!imagenView.sd_imageIndicator) {
    imagenView.sd_imageIndicator = SDWebImageProgressIndicator.defaultIndicator;
 }
  
 NSURL *imageURL = [NSURL URLWithString: self.imageUrl];
 [imagenView sd_setImageWithURL:imageURL
                    placeholderImage:nil
                             options:SDWebImageProgressiveLoad];
 imagenView.animationRepeatCount = 0;

 CGSize superviewSize = imagenView.superview.frame.size;
 imagenView.center = CGPointMake((superviewSize.width / 2), (superviewSize.height / 2));

 UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 370, 200, 30)];
 typeLabel.text = @"Pokemon Types ";
 [self.view addSubview:typeLabel];

 UILabel *statsLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2), 370, 200, 30)];
 statsLabel.text = @"Pokemon Stats ";
 [self.view addSubview:statsLabel];

}

- (void)backButtonPressed:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTablesView {
    typesTableView = [self makeTableView:0 y:400 width:self.view.frame.size.width/2  height:140];
    [typesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifierType"];
    [self.view addSubview:typesTableView];
    
    statsTableView = [self makeTableView:self.view.frame.size.width/2 y:400 width:300 height:140];
    [statsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifierStats"];
    [self.view addSubview:statsTableView];
}

-(UITableView *)makeTableView:(CGFloat)x y:(CGFloat)coordY width:(CGFloat)sizeWidth height:(CGFloat)sizeHeight {

    CGRect tableFrame = CGRectMake(x, coordY, sizeWidth, sizeHeight);

    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];

    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    tableView.separatorColor = [UIColor clearColor];
    tableView.allowsSelection = false;
    tableView.delegate = self;
    tableView.dataSource = self;

    return tableView;
}

- (NSString *)getSubstring:(NSString *)string {
    NSRange startRange = [string rangeOfString:@"(\""];
    NSRange endRange = [string rangeOfString:@"\")"];

    return [string substringWithRange: NSMakeRange (startRange.location+2,(endRange.location-startRange.location-2))];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView == typesTableView){
        return [types count];
        
    } else if(theTableView == statsTableView){
        return [stats count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    UITableViewCell *cell;
   
    if(theTableView == typesTableView){
        CellIdentifier = @"cellIdentifierType";
        cell = [typesTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSString *value = [self getSubstring: [NSString stringWithFormat:@"%@", [types objectAtIndex:indexPath.row]]];
        cell.textLabel.text = value;
        
     } else if(theTableView == statsTableView){
         CellIdentifier = @"cellIdentifierStats";
         cell = [statsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         }
         NSString *value = [self getSubstring: [NSString stringWithFormat:@"%@", [stats objectAtIndex:indexPath.row]]];
         cell.textLabel.text = value;
     }
   
     return cell;
}
@end
