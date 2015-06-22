//
//  CameraViewController.h
//  Goal
//
//  Created by Carolina Bonturi on 6/11/15.
//  Copyright (c) 2015 Carolina Bonturi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPopoverControllerDelegate>
{

    IBOutlet UIImageView* photo;

    IBOutlet UIButton* takePhotoButton;
    IBOutlet UIButton *addPhotoButton;
    IBOutlet UITextField *giftPrice;

}


@end
