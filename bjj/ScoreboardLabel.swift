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
        self.text = text
        self.font = UIFont.systemFontOfSize(fontSize)
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
        self.numberOfLines = 0
        self.setContentHuggingPriority(1000, forAxis: UILayoutConstraintAxis.Vertical)
        self.textColor = UIColor.whiteColor()
        self.textAlignment = textAlignment
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userInteractionEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
