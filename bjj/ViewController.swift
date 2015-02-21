//
//  ViewController.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-20.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func loadView() {
        var label: UILabel = UILabel(frame: CGRectMake(0, 0, 20, 20))
        label.text = "Hello World"
        self.view.addSubview(label)
    }

}

