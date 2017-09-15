//
//  ViewController.swift
//  JPButtonDemo
//
//  Created by Josip Petric on 14/09/2017.
//  Copyright © 2017 BitForest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var breathingButton: JPButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func borderRunnerButtonPressed(_ sender: JPButton) {
        let borderRunnerColor = UIColor(red: 47.0/255.0, green: 240.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        sender.startBorderRunner(withRunnerColor: borderRunnerColor, runnerSize: CGSize(width: 25, height: 12), isRound: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            sender.stopAndRemoveBorderRunner()
        }
    }

    @IBAction func runnerAndBreathingButtonPressed(_ sender: JPButton) {
        let borderRunnerColor = UIColor(red: 204.0/255.0, green: 115.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        sender.startBorderRunner(withRunnerColor: borderRunnerColor, runnerSize: CGSize(width: 25, height: 12), isRound: true, timeToGoRound: 3, withBreathing: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            sender.stopAndRemoveBorderRunner()
        }
    }
}

