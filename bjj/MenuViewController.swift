//
//  MenuViewController.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-20.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupForm()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    func setupForm() {
        let buttonPadding: CGFloat = 10.0
        
        var startButton: UIButton = UIButton(frame: CGRectMake(0, 0, 100, 30))
        startButton.center = self.view.center
        
        startButton.backgroundColor = UIColor.clearColor()
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.grayColor().CGColor
        startButton.setTitle("Competitor", forState: UIControlState.Normal)
        startButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        var competitorTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapCompetitorButton:")
        
        startButton.addGestureRecognizer(competitorTapGesture)
        self.view.addSubview(startButton)
        
        var scoreboardButton: UIButton = UIButton(frame: CGRectMake(0, 0, 100, 30))
        scoreboardButton.center.y = startButton.center.y + startButton.frame.height + buttonPadding
        scoreboardButton.center.x = self.view.center.x
        
        scoreboardButton.backgroundColor = UIColor.clearColor()
        scoreboardButton.layer.borderColor = UIColor.grayColor().CGColor
        scoreboardButton.layer.borderWidth = 1
        scoreboardButton.setTitle("Scoreboard", forState: UIControlState.Normal)
        scoreboardButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        var scoreboardTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapScoreboardButton:")
        
        scoreboardButton.addGestureRecognizer(scoreboardTapGesture)
        
        self.view.addSubview(scoreboardButton)
        
    }
    
    func didTapCompetitorButton(notification: NSNotification) {
        var competitorViewController:AddCompetitorViewController = AddCompetitorViewController()
        
        self.navigationController?.pushViewController(competitorViewController, animated: true
        )
    }
    
    func didTapScoreboardButton(notification: NSNotification) {
        var scoreboardViewController:ScoreboardViewController = ScoreboardViewController()
        
        self.navigationController?.pushViewController(scoreboardViewController, animated: true
        )
    }
}

