//
//  ViewController.swift
//  API Demo
//  Mini project from Udemy (iOS10 & Swift 3 complete developer) course
//
//  Created by admin on 25/01/2018.
//  Copyright © 2018 Josh_Dog101. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    @IBAction func btnSubmit(_ sender: Any) {
    
        // this api is only finds UK cities.
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + txtCity.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=69c89e1c738adba61fd744f0587a88bb") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    
                } else {
                    if let urlContent = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            print(jsonResult["name"])
                            
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                DispatchQueue.main.sync(execute: {
                                    self.displayLabel.text = description
                                })
                            }
                            
                        } catch {
                            print("JSON Processing Failed")
                        }
                    }
                }
            }
            task.resume()
        } else {
            displayLabel.text = "Couldn't find weather for the city you specified. Please try another."
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

