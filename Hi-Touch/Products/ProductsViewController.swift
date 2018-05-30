//
//  ProductsViewController.swift
//  Hi-Touch
//
//  Created by Swathi B on 10/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit

class ProductsViewController: ProductAPIController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    var filterBarButton: UIBarButtonItem?
    var filterButton: UIButton?
    var popoverViewController: FilterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popoverViewController = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController

        self.title = "Products"
        addRightButton()
        activityIndicator.startAnimating()
        searchProducts(with: "", completionHandler: {(data,error) in
            self.activityIndicator.stopAnimating()
            if error == nil {
                
                if let resultSet = data!["resultSet"] as? [[String: AnyObject]] {
                    
                    let array = resultSet.map({ (dict) -> Product in
                        let product = Product(dictionary: dict)
                        return product!
                    })
                    self.productList = array
                }
                
                if let aggregationsDic = data!["aggregations"] as? [String: AnyObject] {
                    self.popoverViewController?.aggregation = Aggregations(dictionary: aggregationsDic)
                }
                self.productsCollectionView.reloadData()
            }
        })
    }
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x:0, y:0, width:180,height:40))
        viewFN.backgroundColor = UIColor.clear
        let button1 = UIButton(frame: CGRect(x:0,y:0, width:180, height:40))
        button1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button1.setTitle("Filter", for: .normal)
        button1.addTarget(self, action: #selector(self.filterList), for: .touchUpInside)
        viewFN.addSubview(button1)
        let leftBarButtonItem = UIBarButtonItem(customView: viewFN)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func filterList() {
//        self.popoverViewController?.filterTableView.reloadData()
        popoverViewController?.modalPresentationStyle = .popover
        popoverViewController?.preferredContentSize   = CGSize(width: 400, height: self.view.frame.size.height-100)
        let popoverPresentationViewController = popoverViewController?.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverPresentationViewController?.delegate = self as? UIPopoverPresentationControllerDelegate
        popoverPresentationViewController?.sourceView = self.navigationItem.leftBarButtonItem?.customView
        popoverPresentationViewController?.sourceRect = CGRect(x: (self.navigationItem.leftBarButtonItem?.customView!.frame.size.width)!/2-15, y: (self.navigationItem.leftBarButtonItem?.customView!.frame.size.height)!/2-15, width: 30, height: 30)
        present(popoverViewController!, animated: true, completion: nil)
    }
}

extension ProductsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count >= 3) {
            print(searchText)
            activityIndicator.startAnimating()
            searchProducts(with: searchBar.text!, completionHandler: {(data,error) in
                self.activityIndicator.stopAnimating()
                if error == nil {
                    if let resultSet = data!["resultSet"] as? [[String: AnyObject]] {
                        
                        let array = resultSet.map({ (dict) -> Product in
                            let product = Product(dictionary: dict)
                            return product!
                        })
                        self.productList = array
                    }
                    
                    if let aggregationsDic = data!["aggregations"] as? [String: AnyObject] {
                        self.popoverViewController?.aggregation = Aggregations(dictionary: aggregationsDic)
                    }
                    self.productsCollectionView.reloadData()
                }
            })
        }
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Product Cell", for: indexPath) as! ProductsCollectionCell
        cell.setUp(product: productList[indexPath.row])
        return cell
    }
    
}

extension ProductsViewController: UICollectionViewDelegate {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 250, height: 200)
    }
}
