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

        let url: URL = URL(string: "http://127.0.0.1:8000/api/coupons/")!
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
        
        let coupon = self.coupons[indexPath.row]
        //セルを作る
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponCell", for: indexPath as IndexPath)
        
        tableView.rowHeight = 400
        
         //各ラベルに値を設定する
        let labelBenefit = cell.viewWithTag(1) as! UILabel
        labelBenefit.text = (coupon["benefit"] as! String)

        let labelExplanation = cell.viewWithTag(2) as! UILabel
        labelExplanation.text = (coupon["explanation"] as! String)

        let labelStore = cell.viewWithTag(3) as! UILabel
        labelStore.text = (coupon["store"] as! String)

        let labelDay = cell.viewWithTag(4) as! UILabel
        labelDay.text = "有効期間： " + (coupon["start"] as! String) + " 〜 " + (coupon["deadline"] as! String)
        
        // クーポン画像を表示
        let couponImageView = cell.viewWithTag(5) as! UIImageView
        if let urlString = coupon["image"] as? String {
            couponImageView.image = UIImage(named: urlString) //オプショナルバインディングで値を取り出す
        } else {
            couponImageView.image = UIImage(named: "no-coupon-image.png") //nilの場合は固定画像表示
        }
        return cell
    }
    
}

