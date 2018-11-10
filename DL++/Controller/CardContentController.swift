//
//  CardContentController.swift
//  DL++
//
//  Created by Nurtugan on 11/8/18.
//  Copyright © 2018 hackday. All rights reserved.
//

import UIKit

class CardContentController: UIViewController {

    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var rk1Label: UILabel!
    @IBOutlet weak var rk2Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setValues(tch: String, att: Int, rk1: Int, rk2: Int) {
        teacherLabel.text = tch
        attendanceLabel.text = "\(att)%"
        rk1Label.text = "\(rk1)%"
        rk2Label.text = "\(rk2)%"
    }
}
