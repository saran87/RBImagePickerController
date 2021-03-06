//
//  RBImagePickerController.m
//  RBImagePicker
//
//  Created by Roshan Balaji on 1/31/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import "RBImagePickerController.h"
#import "RBImageCollectionController.h"
@interface RBImagePickerController ()

@property(nonatomic, strong) RBImageCollectionController *assetCollection;

@end

@implementation RBImagePickerController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   
    self.assetCollection = [[RBImageCollectionController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.assetCollection.pickerDelegate = self;
    
    self.assetCollection.navigationController.title = self.title;
    if(self.assetCollection.title == nil){
        self.assetCollection.navigationItem.title = @"Photos";
    }
    if(self.selectionType != RBSingleImageSelectionType){
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleBordered
                                   target:self action:@selector(onDone:)];
    
    [self.assetCollection.navigationItem setRightBarButtonItem:doneButton];
    
    }
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStyleBordered
                                     target:self action:@selector(onCancel:)];
    
    [self.assetCollection.navigationItem setLeftBarButtonItem:cancelButton];
    [self.assetCollection.navigationItem.rightBarButtonItem setEnabled:NO];

    [self pushViewController:self.assetCollection animated:NO];
    
   

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onCancel:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)onDone:(id)sender{
    
    [self finishPickingImages];
    
}

-(void)finishPickingImages{
    
    [self.sourceDelegate didFinishSelectingImages:[self.assetCollection getSelectedAssets]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
