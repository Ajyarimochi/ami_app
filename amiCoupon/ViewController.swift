//
//  ViewController.swift
//  amiCoupon
//
//  Created by 杉浦由季 on 2019/10/23.
//  Copyright © 2019 startup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let url: URL = URL(string: "http://127.0.0.1:8000/coupon/?coupon_code=0001")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            do  {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                print(json)
                }
            catch {
                print(error)
                }
            
            print("data: \(String(describing: data))")
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")
        })
        task.resume()
        
    }
}

