//
//  ProfileVC.swift
//  DL++
//
//  Created by fsociety.1 on 11/10/18.
//  Copyright © 2018 hackday. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Intents

class ProfileVC: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = 83
        userImage.layer.masksToBounds = false
        userImage.clipsToBounds = true
        config()
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isAuthorized")
        UserDefaults.standard.synchronize()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateInitialViewController()
            self.present(vc!, animated: false, completion: nil)
        }
    }
    
    func config() {
        let intent = LessonNowIntent()
        
        intent.suggestedInvocationPhrase = "What lesson is now"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
        
        let intent1 = LessonNextIntent()
        
        intent1.suggestedInvocationPhrase = "What lesson is next"
        
        let interaction1 = INInteraction(intent: intent1, response: nil)
        
        interaction1.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
        
        let intent2 = LessonCalendarIntent()
        
        intent2.suggestedInvocationPhrase = "What is the"
        intent2.sequencing = "first"
        intent2.dayOfWeek = "Saturday"
        let interaction2 = INInteraction(intent: intent2, response: nil)
        
        interaction2.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }
    
    @IBAction func addToSiri(_ sender: Any) {
        INPreferences.requestSiriAuthorization { status in
            switch status {
            case .authorized:
                print("We have access!")
            default:
                print("Not granted")
                break
            }
        }
    }
}
