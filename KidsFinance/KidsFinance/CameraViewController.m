//
//  CameraViewController.m
//  Goal
//
//  Created by Carolina Bonturi on 6/11/15.
//  Copyright (c) 2015 Carolina Bonturi. All rights reserved.
//

#import "CameraViewController.h"

#define MAX_IMAGE_WIDTH 200

@interface CameraViewController ()
@property (strong, nonatomic) UIPopoverController *imagePickerPopOver;
@property (strong, nonatomic) UIImage *image;

@end


@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/****************IB ACTIONS****************/
- (IBAction)takePhoto:(UIButton *)sender {
    [self presentImagePicker: UIImagePickerControllerSourceTypeCamera sender: sender];
}


- (IBAction)addPhoto:(UIButton *)sender {
    [self presentImagePicker: UIImagePickerControllerSourceTypePhotoLibrary sender: sender];

}


- (void)presentImagePicker:(UIImagePickerControllerSourceType) sourceType sender: (UIButton *)sender
{
    /* check if the camera is available; if it is, set that type as the sorce type */
    if(!self.imagePickerPopOver && [UIImagePickerController isSourceTypeAvailable:sourceType]) {
        NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType: sourceType];
        if([availableMediaTypes containsObject:(__bridge NSString *)kUTTypeImage]) {

            /* instantiate and modally present a camera interface */
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = sourceType;
            picker.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            /* present the picker */
            if((sourceType != UIImagePickerControllerSourceTypeCamera) && (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
                /* in the iPad case, we can build a POPOVER */
                //self.imagePickerPopOver = [[UIPopoverController alloc] initWithContentViewController:picker];
                //[self.imagePickerPopOver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                //self.imagePickerPopOver.delegate = self;
            } else {

                [self presentViewController:picker animated:YES completion:nil];
            }
        }
    }
}


/* Popover dissmiss methods */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.imagePickerPopOver = nil;
}


/* For responding to the user tapping Cancel */
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/* Delegate will be notified when user is done */
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    NSLog(@"hello");
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if(!image) image = info[UIImagePickerControllerOriginalImage];
    
    // Handle a still image capture
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        /* reseting the frame of ImageView to be no more than 200 pixel wide */
        CGRect frame = imageView.frame;
        if(frame.size.width > MAX_IMAGE_WIDTH) {
            frame.size.height = (frame.size.height / frame.size.width) * MAX_IMAGE_WIDTH;
            frame.size.width = MAX_IMAGE_WIDTH;
        }
        imageView.frame = frame;
        
        /* put the view in a random location TODO */
        //[self setRandomLocationForView: imageView];
        //[[self view] addSubview: picker];
    }
    
    /* dismiss the picker */
    if(self.imagePickerPopOver) {
        [self.imagePickerPopOver dismissPopoverAnimated:YES]; /* it means: take the screen off */
        self.imagePickerPopOver = nil; /* it means: local property nil */
    } else {
        [self dismissViewControllerAnimated:YES completion:nil]; /* in the modal case */
    }
}

    
@end

