//
//  setupFormViewController.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-21.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

import UIKit

class AddCompetitorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    var tableView: UITableView!
    var rowArray: NSArray!
    var numberFieldTypeArray: NSArray!
    var emailFieldTypeArray: NSArray!
    var pushFieldTypeArray: NSArray!
    
    var count: NSInteger = 0
    
    var cellReusableIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Competitor"
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Grouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.rowArray = [
            [["firstName":"First Name"], ["lastName":"Last Name"]],
            [["age":"Age"], ["weight":"Weight"], ],
            [["gender":"Gender"],["ageGroup":"Age Group"]],
            [["division":"Division"], ["belt":"Belt Rank"]],
            [["city":"City"], ["country":"Country"]],
            [["phone": "Phone"], ["email": "E-Mail"]],
            [["academyName": "Academy Name"], ["academyLocation":"Academy Location"]],
            [["notes": "Notes"]]
        ]
        
        self.numberFieldTypeArray = ["age", "weight", "phone"]
        self.emailFieldTypeArray = ["email"]
        self.pushFieldTypeArray = ["belt"]
    
        self.tableView.reloadData()

        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:CompetitorTableCell = CompetitorTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellReusableIdentifier)
        var sectionIndex: NSInteger = indexPath.section

        var keyStringDictionary:NSArray = self.rowArray[indexPath.row] as NSArray
        self.count++

        cell.rowArray = self.rowArray[indexPath.row] as NSArray
        
        cell.setupCell()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: - UITextField Delegate Methods
    
    
    
    
//    - (void)keyboardWillShow:(NSNotification *)notification;
//    {
//    NSDictionary *userInfo = [notification userInfo];
//    NSValue *keyboardBoundsValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGFloat keyboardHeight = [keyboardBoundsValue CGRectValue].size.height;
//    
//    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    UIEdgeInsets insets = [[self tableView] contentInset];
//    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
//    [[self tableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, keyboardHeight, insets.right)];
//    [[self view] layoutIfNeeded];
//    } completion:nil];
//    }
//    
//    - (void)keyboardWillHide:(NSNotification *)notification;
//    {
//    NSDictionary *userInfo = [notification userInfo];
//    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    UIEdgeInsets insets = [[self tableView] contentInset];
//    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
//    [[self tableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, 0., insets.right)];
//    [[self view] layoutIfNeeded];
//    } completion:nil];
//    }
    
}
