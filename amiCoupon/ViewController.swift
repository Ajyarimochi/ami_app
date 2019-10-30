//
//  ViewController.swift
//  amiCoupon
//
//  Created by 杉浦由季 on 2019/10/23.
//  Copyright © 2019 startup. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var couponBenefit: String = "" {
        didSet{
            tableView.reloadData()
        }
    }
    var couponDeadline: String = "" {
        didSet{
            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let url: URL = URL(string: "http://127.0.0.1:8000/coupon/")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            do  {
                let couponDataArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                let couponData = couponDataArray.map { (couponData) -> [String: Any] in
                    return couponData as! [String: Any]
                }
                print(couponData[0]["coupon_benefits"] as! String)
                print(couponData[1]["coupon_benefits"] as! String)

                
                DispatchQueue.main.async() { () -> Void in
//                    self.couponBenefit = couponData["coupon_benefits"] as! String
//                    self.couponDeadline = couponData["coupon_deadline"] as! String
                    }
                }
            catch {
                print(error)
                }
        })
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを作る
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "couponCell")
        //テキストにクーポン特典を設定
        cell.textLabel?.text = self.couponBenefit
        //サブテキストにクーポンの有効期限を設定
        cell.detailTextLabel?.text = "有効期限：" + self.couponDeadline

        return cell
    }
    
}

