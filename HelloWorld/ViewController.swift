//
//  ViewController.swift
//  HelloWorld
//
//  Created by Jonathan Moreno on 1/4/17.
//  Copyright © 2017 Jonathan Moreno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var welcomeBtn: UIButton!
    @IBOutlet weak var titleImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func welcomePressed(_ sender: Any) {
        background.isHidden = false
        titleImg.isHidden = false 
        welcomeBtn.isHidden = true
    }

}

