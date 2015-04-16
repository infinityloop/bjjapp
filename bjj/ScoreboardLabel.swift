//
//  ScoreboardLabel.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-04-07.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

class ScoreboardLabel: UILabel {
    init(frame: CGRect, text:NSString, fontSize:CGFloat, textAlignment:NSTextAlignment) {
        super.init(frame: frame)
        self.text = text as String
        self.font = UIFont.systemFontOfSize(fontSize)
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1
        self.numberOfLines = 0
        self.setContentHuggingPriority(0, forAxis: UILayoutConstraintAxis.Vertical)
        self.setContentCompressionResistancePriority(0, forAxis: UILayoutConstraintAxis.Vertical)
        self.textColor = UIColor.whiteColor()
        self.textAlignment = textAlignment
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userInteractionEnabled = true
        self.baselineAdjustment = UIBaselineAdjustment.AlignCenters
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
