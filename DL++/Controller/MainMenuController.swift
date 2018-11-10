//
//  MainMenuController.swift
//  DL++
//
//  Created by Nurtugan on 11/7/18.
//  Copyright © 2018 hackday. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

struct SubjectsJSON: Codable {
    let subjects: [Subject]
}

struct Subject: Codable {
    let subjectName, subjectImage, teacherName: String
    let attendance, mark1, mark2: Int
}

class MainMenuController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saveData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubjectCell
        let cardContent = storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! CardContentController
        cell.cardView.shouldPresent(cardContent, from: self, fullscreen: true)
        cell.displayContent(title: saveData[indexPath.row].subjectName, itemTitle: saveData[indexPath.row].teacherName)

        cardContent.setValues(tch: saveData[indexPath.row].teacherName, att: saveData[indexPath.row].attendance, rk1: saveData[indexPath.row].mark1, rk2: saveData[indexPath.row].mark2)
        
        Alamofire.request(saveData[indexPath.row].subjectImage).responseData { response in
            //cell.cardView.icon = UIImage(data: response.data!)!
            if let resData = response.data {
                if let im = UIImage(data: resData) {
                    cell.cardView.backgroundImage = im
                }
            }
        }
        
        return cell
    }
    
    
    var saveData = [Subject]()
    
    func getData() {
        let url = "https://dlhackday.herokuapp.com/getSubjects"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            do {
                let json = JSON(response.result)
                guard let result = response.data else { return }
                let res = try JSONDecoder().decode(SubjectsJSON.self, from: result)
                self.saveData = res.subjects
                self.collectionView?.reloadData()
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }
    }
    
}

