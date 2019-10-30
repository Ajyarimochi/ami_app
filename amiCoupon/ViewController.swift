//
//  ViewController.swift
//  amiCoupon
//
//  Created by うらー on 2019/10/23.
//  Copyright © 2019 startup. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var coupons: [[String: Any]] = [] { //パースした[String: Any]型のクーポンデータを格納するメンバ変数
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url: URL = URL(string: "http://127.0.0.1:8000/coupon/")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            do  {
                let couponDataArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                let couponData = couponDataArray.map { (couponData) -> [String: Any] in
                    return couponData as! [String: Any]
                }
                
                DispatchQueue.main.async() { () -> Void in
                    self.coupons = couponData
                    }
                }
            catch {
                print(error)
                }
        })
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coupons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを作る
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "couponCell")
        let coupon = self.coupons[indexPath.row]
        //テキストにクーポン特典を設定
        cell.textLabel?.text = (coupon["coupon_benefits"] as! String)
         //サブテキストにクーポンの有効期限を設定
        cell.detailTextLabel?.text = "有効期限：" + (coupon["coupon_deadline"] as! String)

        return cell
    }
    
}

