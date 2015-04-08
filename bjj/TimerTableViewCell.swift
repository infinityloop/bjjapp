//
//  TimerTableViewCell.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-03-03.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

class TimerTableViewCell: UITableViewCell {
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, row: NSInteger) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.blackColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        var numLabel: TimerLabel = TimerLabel(frame: CGRectZero, timeNumber: row)
        numLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.contentView.addSubview(numLabel)
        
        var viewDictionary: NSDictionary = ["numLabel": numLabel]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[numLabel]|", options: nil, metrics: nil, views: viewDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[numLabel]|", options: nil, metrics: nil, views: viewDictionary))
        
//        var widthConstraint: NSLayoutConstraint = NSLayoutConstraint(item: numLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0)
//        
//        var heightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: numLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0)
//        heightConstraint.priority = 300
        
//        self.contentView.addConstraint(widthConstraint)
//        self.contentView.addConstraint(heightConstraint)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
