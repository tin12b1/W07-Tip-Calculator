//
//  ViewController.swift
//  W07_Tip_Calculator_NIT
//
//  Created by Cntt16 on 5/19/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipResultTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateRightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var text=""
        switch UIDevice.current.orientation{
        case .portrait:
            text="Portrait"
            billTopConstraint.constant = 40
            tipTopConstraint.constant = 30
            numberTopConstraint.constant = 30
            btnCalculateTopConstraint.constant = 30
            btnCalculateLeftConstraint.constant = 80
            btnCalculateRightConstraint.constant = 80
            resultTopConstraint.constant = 30
            tipResultTopConstraint.constant = 30
            totalTopConstraint.constant = 30
        case .portraitUpsideDown:
            text="PortraitUpsideDown"
        case .landscapeLeft:
            billTopConstraint.constant = 10
            tipTopConstraint.constant = 10
            numberTopConstraint.constant = 10
            btnCalculateTopConstraint.constant = 10
            btnCalculateLeftConstraint.constant = 222
            btnCalculateRightConstraint.constant = 222
            resultTopConstraint.constant = 10
            tipResultTopConstraint.constant = 10
            totalTopConstraint.constant = 10
            text="LandscapeLeft"
        case .landscapeRight:
            billTopConstraint.constant = 10
            tipTopConstraint.constant = 10
            numberTopConstraint.constant = 10
            btnCalculateTopConstraint.constant = 10
            btnCalculateLeftConstraint.constant = 222
            btnCalculateRightConstraint.constant = 222
            resultTopConstraint.constant = 10
            tipResultTopConstraint.constant = 10
            totalTopConstraint.constant = 10
            text="LandscapeRight"
        default:
            text="Another"
        }
        NSLog("You have moved: \(text)")        
    }
    
    
}

