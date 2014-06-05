//
//  BNRDetailViewController.m
//  HomePwner
//
//  Created by William Kong on 2014-05-22.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController


#pragma mark - Controller life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"--BNRDetailViewController %@", NSStringFromSelector(_cmd));
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
    
    // set contentMode of image view
    iv.contentMode = UIViewContentModeScaleAspectFit;
    
    // do NOT produce a translated constraint for this view
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    
    // the image view was a subview of the view
    [self.view addSubview:iv];
    
    // the image view was pointed to by imageView property
    self.imageView = iv;
    
    // set vertical priorties to be less than those of the other subviews
    [self.imageView setContentHuggingPriority:200
                                      forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700
                                                    forAxis:UILayoutConstraintAxisVertical];
    
    NSDictionary *nameMap = @{@"imageView":self.imageView,
                              @"dateLabel":self.dateLabel,
                              @"toolbar":self.toolbar};
    
    // imageView is 0 pts from superview at left and right edges
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:nameMap];
    // imageView is 8 pts from dateLabel at its top edge
    // and 8 pts from toolbar at its bottom edge
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-[imageView]-[toolbar]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:nameMap];
    
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // You need an NSDateFormatter that will turn a date into a simple data string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // If there's an image key, then display it on screen
    NSString *key = item.itemKey;
    UIImage *img = [[BNRImageStore sharedStore] imageForKey:key];
    self.imageView.image = img;
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

#pragma mark - Property setter/getters
// override the default setter
- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

#pragma mark - Actions
// handler for camera button
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    // if device has a camera, take a pictre, otherwise, pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    // place image picker on screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// called whenever user taps the background
- (IBAction)backgroundTapped:(id)sender
{
    // use to make the view or any subview that is the first responder resign
    [self.view endEditing:YES];
}

#pragma mark - ImagePickerController delegate
// handler for finish picking media event
- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // get picked image from dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // store image in the BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image
                                   forKey:self.item.itemKey];
    
    // put that image onto screen in our image view
    self.imageView.image = image;
    
    // take image picker off screen; client is responsible for dismissing controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField delegate
// called when 'return' key pressed. 
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
