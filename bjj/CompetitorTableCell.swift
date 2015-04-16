//
//  CompetitorTableCell.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-21.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

import UIKit

enum valueType {
    case TextField
    case NumberField
    case EmailField
    case pushField
}

class CompetitorTableCell: UITableViewCell {

    var rowArray: NSArray!
    var valueField: UITextField!
    var valueKey: NSString!
    var secondaryField: UITextField?
    var secondaryValueKey :NSString?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        var keyLabel: UILabel = UILabel()
//        keyLabel.text = self.value
//        keyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.addSubview(keyLabel)


//        valueField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
//        var viewDictionary:NSDictionary = ["keyLabel": keyLabel, "valueField": valueField]
//        
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[keyLabel]-[valueField]-|", options: nil, metrics: nil, views: viewDictionary))
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[keyLabel]-|", options: nil, metrics: nil, views: viewDictionary))
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[valueField]-|", options: nil, metrics: nil, views: viewDictionary))
//        
//        self.addConstraint(NSLayoutConstraint(item: keyLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: valueField, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        let spacing: CGFloat = 5.0
        let offset: CGFloat = 10.0
        var cellWidth: CGFloat = self.bounds.width
        var textWidth: CGFloat = cellWidth / CGFloat(self.rowArray.count) - spacing - offset
        
        var valueField:UITextField = UITextField(frame: CGRectMake(offset, 0, textWidth - spacing, self.bounds.height))
        self.valueKey = self.rowArray.objectAtIndex(0).allKeys[0] as! NSString
        valueField.placeholder = self.rowArray.objectAtIndex(0).allValues[0] as! NSString as String
        self.addSubview(valueField)
        self.valueField = valueField

        if (self.rowArray.count > 1) {
            var separator: UIView = UIView(frame: CGRectMake(0, 0, 1, self.bounds.height))
            separator.backgroundColor = UIColor(white: 0.75, alpha: 1)
            separator.frame.origin.x = textWidth + offset - spacing
            self.addSubview(separator)
            
            var secondaryValueField:UITextField = UITextField(frame: CGRectMake(offset, 0, textWidth, self.bounds.height))
            secondaryValueField.placeholder = self.rowArray.objectAtIndex(1).allValues[0] as! NSString as String
            secondaryValueField.frame.origin.x = textWidth + 2*spacing + offset
            self.addSubview(secondaryValueField)
            self.secondaryField = secondaryValueField
        }

        
    }
}
