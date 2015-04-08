//
//  TimerLabel.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-03-03.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//


class TimerLabel: UILabel {
    init(frame: CGRect, timeNumber: NSInteger) {
        super.init(frame: frame)
        self.text = NSString(format:"%02d",  timeNumber)
        self.textColor = UIColor.whiteColor()
        self.setContentHuggingPriority(0, forAxis: UILayoutConstraintAxis.Vertical)
        self.setContentCompressionResistancePriority(0, forAxis: UILayoutConstraintAxis.Vertical)
        self.textAlignment = NSTextAlignment.Center
        self.numberOfLines = 0
        self.font = UIFont.systemFontOfSize(140)
        self.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
