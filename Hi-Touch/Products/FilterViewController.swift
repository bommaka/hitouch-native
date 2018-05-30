//
//  FilterViewController.swift
//  Hi-Touch
//
//  Created by Swathi B on 16/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit
import Alamofire

extension Notification.Name {
    static let search = Notification.Name("product search")
}

class FilterViewController: ProductAPIController {
    var isFilterApplied = false
    var aggregation: Aggregations?

    @IBOutlet weak var filterTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.tableFooterView = UIView()
//        NotificationCenter.default.addObserver(self, selector: #selector(allproducts(notification:)), name: .search, object: nil)
    }
    
//     override func allProducts(result: Result<Any>, error: Error?) {
//        super.allProducts(result: result, error: error)
//        print(result, error)
//        filterTableView.reloadData()
//    }
    
//    @objc func allproducts(notification: NSNotification) {
//        if let aggregation = notification.object as? Aggregations {
//            aggregations = aggregation
//        }
//        filterTableView.reloadData()
//    }
    
    func filterExist(section: Int) -> [Buckets]? {
        switch section {
        case 0:
            if let originators_name_full = aggregation?.originators_name_full, let buckets = originators_name_full.buckets {
                return buckets
            }
        case 1:
            if let originators_name_full = aggregation?.versionTypeCode, let buckets = originators_name_full.buckets {
                return buckets
            }
        case 2:
            if let originators_name_full = aggregation?.datePublication, let buckets = originators_name_full.buckets {
                return buckets
            }
        case 3:
            if let originators_name_full = aggregation?.categoriesCode, let buckets = originators_name_full.buckets {
                return buckets
            }
        case 4:
            if let originators_name_full = aggregation?.categoriesCode, let buckets = originators_name_full.buckets {
                return buckets
            }
        default:
            return nil
        }
        return nil
    }
}


extension FilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let buckets = filterExist(section: section) {
            return buckets.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell") as! FilterTableViewCell
        if let buckets = filterExist(section: indexPath.section) {
            let bucket = buckets[indexPath.row]
            if let name = bucket.key, let count = bucket.doc_count {
                cell.setup(withTitle: name, detailsText: "\(count)", level: 0)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let buckets = filterExist(section: section), buckets.count > 0 {
            switch section {
            case 0:
                return "SUBJECT"
            case 1:
                return "PUBLICATION DATE"
            case 2:
                return "Choose from year"
            case 3:
                return "IMPRINT"
            case 4:
                return "VERSION TYPE"
            case 5:
                return "AUTHORS"
            default:
                return ""
            }
        }
        return ""
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
