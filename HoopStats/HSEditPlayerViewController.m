//
//  HSEditPlayerViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/14/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSEditPlayerViewController.h"

@interface HSEditPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UITextField *playerFirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *playerLastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *playerNumberTextField;

@end

@implementation HSEditPlayerViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)uploadPhotoButtonPressed {
    NSLog(@"Upload Button Pressed");
}

- (IBAction)takePhotoButtonPressed {
    NSLog(@"Take Photo Button Pressed");
}

-(NSString*)playerFistName
{
    return self.playerFirstNameTextField.text;
}

-(NSString*)playerLastName
{
    return self.playerLastNameTextField.text;
}

-(NSNumber*)playerNumber
{
    NSString *numberString = self.playerNumberTextField.text;
    return @(numberString.intValue);
}

@end
