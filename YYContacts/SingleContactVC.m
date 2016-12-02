//
//  SingleContactVC.m
//  YYContacts
//
//  Created by iosdev on 2016/12/2.
//  Copyright © 2016年 QSYJ. All rights reserved.
//

#import "SingleContactVC.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <ContactsUI/ContactsUI.h>

@interface SingleContactVC ()<ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>

@end

@implementation SingleContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"style:UIBarButtonItemStylePlain target:self action:@selector(addEvent)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addEvent {
    //iOS版本判断
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        [self showContactPickerController];
    }
    else {
        [self showPeoplePickerController];
    }
}

#pragma mark Show all contacts CNContactPickerViewController
-(void)showContactPickerController {
    //    AB_DEPRECATED("Use CNContactPickerViewController from ContactsUI.framework instead")
    CNContactPickerViewController * contactVc = [CNContactPickerViewController new];
    contactVc.delegate = self;
    [self presentViewController:contactVc animated:YES completion:^{
    }];
}

//选择完成代理回调
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    //    NSLog(@"name:%@,---%@,---%@",contact.familyName,contact.givenName,contact.middleName);
    //    CNLabeledValue * labValue1 = [contact.phoneNumbers firstObject];
    //    NSLog(@"phone:%@",[labValue1.value stringValue]);
    NSString *familyName = contact.familyName;
    NSString *givenName = contact.givenName;
    NSString *fullName;
    if (familyName && givenName) {
        fullName = [NSString stringWithFormat:@"%@%@",familyName,givenName];
    }
    else if (familyName && !givenName) {
        fullName = familyName;
    }
    else if (!familyName && givenName) {
        fullName = familyName;
    }
    else {
        fullName = nil;
    }
//    tf_name.text = fullName;
//    //电话是多个, 要用数组来处理
//    CNLabeledValue * labValue = [contact.phoneNumbers firstObject];
//    NSString *tel = [labValue.value stringValue];
//    if (tel) {
//        tf_number.text = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];;
//    }
}
//取消选择回调
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark Show all contacts
// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
// The application only shows the phone, email, and birthdate information of the selected contact.
-(void)showPeoplePickerController
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    // Display only a person's phone, email, and birthdate
    //    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
    //                               [NSNumber numberWithInt:kABPersonEmailProperty],
    //                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],nil];
    
    picker.displayedProperties = displayedItems;
    // Show the picker
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate methods
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person {
    NSLog(@"didSelectPerson");
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *fullName;
    if (firstName && lastName) {
        fullName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
    }
    else if (firstName && !lastName) {
        fullName = firstName;
    }
    else if (!firstName && lastName) {
        fullName = lastName;
    }
    else {
        fullName = nil;
    }
//    tf_name.text = fullName;
//    //电话是多个, 要用数组来处理
//    ABMultiValueRef telRef;
//    telRef = ABRecordCopyValue(person,  kABPersonPhoneProperty);
//    if (ABMultiValueGetCount(telRef) > 0) {
//        NSString * tel = (__bridge NSString *)ABMultiValueCopyValueAtIndex(telRef, 0);
//        NSLog(@"%@",tel);
//        tf_number.text = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];;
//    }
}

// Called after a property has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    NSLog(@"didSelectPerson property");
}

// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

// Dismisses the people picker and shows the application when users tap Cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
