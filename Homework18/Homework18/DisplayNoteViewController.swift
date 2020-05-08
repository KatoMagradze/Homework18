//
//  DisplayNoteViewController.swift
//  Homework18
//
//  Created by Kato on 5/8/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {

    @IBOutlet weak var displayNoteLabel: UILabel!
    var textToDisplay : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayNoteLabel.text = textToDisplay

        // Do any additional setup after loading the view.
    }
    

}
