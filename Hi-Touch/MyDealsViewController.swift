//
//  MyDealsViewController.swift
//  Hi-Touch
//
//  Created by Swathi B on 10/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit
import Alamofire

class MyDealsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dealsCollectionView: UICollectionView!
    
    var dealsList =  [Deals]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Deals"
        guard let userToken =  UserDefaults.standard.string(forKey: userToken) else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization":  userToken,
            "user_id": "dinesh.kumar@informa.com"
        ]
        
        Alamofire.request(myDealsURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            self.activityIndicator.stopAnimating()
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                    print(response.result.value)
                    if let jsonArray = data as? [[String:AnyObject]] {
                        print(jsonArray)
                        let array = jsonArray.map({ (dict) -> Deals in
                            let deals = Deals(dictionary: dict)
                            return deals!
                        })
                        self.dealsList = array
                        self.title = "My Deals(\(self.dealsList.count))"
                        self.dealsCollectionView.reloadData()
                    }
                }
                break
                
            case .failure(_):
                print(response.result.error)
                break
            }
        }
    }
}

extension MyDealsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dealsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "My Deals Cell", for: indexPath) as! MyDealsCollectionCell
        cell.setUp(deal: dealsList[indexPath.row])
        return cell
    }

}

extension MyDealsViewController: UICollectionViewDelegate {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 250, height: 150)
    }
}
