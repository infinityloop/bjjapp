//
//  TimerTableView.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-03-02.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

enum TimeTableValueTypes: Int {
    case Seconds
    case Minutes
}

protocol TimeTableDelegate {
    func timeTableDidUpdate(deltaCentiseconds: Double)
}

class TimerTableView: UITableView, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    var rows: NSInteger!
    var value: NSInteger?
    
    var selectedRow:NSInteger = 0
    
    var valueType:TimeTableValueTypes!
    
    var startSelectValue: Int!
    
    var timeTableDelegate: TimeTableDelegate!
    
    var isScrolling: Bool = false
    
    // MARK: - Instantiation Methods
    
    init(rows: NSInteger, frame: CGRect) {
        super.init(frame: frame, style: UITableViewStyle.Plain)
        self.rows = rows
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.backgroundColor = UIColor.blackColor()
        self.delegate = self
        self.dataSource = self
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.decelerationRate = UIScrollViewDecelerationRateFast
        self.tableHeaderView = UIView(frame: CGRectZero)
        self.tableFooterView = UIView(frame: CGRectZero)
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 90
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Class Methods
    
    func scrollToRow(row: NSInteger) {
        var rowIndexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
        self.scrollToRowAtIndexPath(rowIndexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
    }
    
    // MARK: - UITableview Delegate Methods

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TimerTableViewCell = TimerTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "timerTableViewCell", row: indexPath.row)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
    // MARK: - UIScrollViewDelegate Methods
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        var indexPath: NSIndexPath = self.getIndexPathForCell()
        
        if (!self.isScrolling) {
            self.startSelectValue = indexPath.row
            self.isScrolling = true
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (decelerate == false) {
            self.centerTable()
            self.calculateTimeDifference()
            self.isScrolling = false
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.centerTable()
        self.calculateTimeDifference()
        self.isScrolling = false
    }
    
    func centerTable() {
        var indexPathForCell: NSIndexPath = self.getIndexPathForCell()
        
        self.scrollToRowAtIndexPath(indexPathForCell, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
    }
    
    func getIndexPathForCell() -> NSIndexPath {
        return self.indexPathForRowAtPoint(CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)))!
    }
    
    func calculateTimeDifference() {
        if (self.startSelectValue == nil) {
            return
        }

        var indexPathForCell: NSIndexPath = self.getIndexPathForCell()
        var timeDifference = indexPathForCell.row - self.startSelectValue
        println(timeDifference)
        if (timeDifference == 0) {
            return
        }
        
        if (self.valueType == TimeTableValueTypes.Seconds) {
            self.timeTableDelegate.timeTableDidUpdate((Double)(timeDifference * 100))
        } else if (self.valueType == TimeTableValueTypes.Minutes) {
            self.timeTableDelegate.timeTableDidUpdate((Double)(timeDifference * 6000))
        }
        
        self.startSelectValue = nil
    }
}
