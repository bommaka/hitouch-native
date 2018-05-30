//
//  ProductsCollectionCell.swift
//  Hi-Touch
//
//  Created by Swathi B on 14/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit
import Kingfisher

class ProductsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var routeledge: UILabel!
    
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor!.cgColor
        }
    }
    
    func setUp(product: Product) {
        if let mediaFile = getCoverImageIndexWithPriority(product: product) {
            productImage.kf.setImage(with: URL(string: mediaFile))
        }
        productName.text = product.title
    }
    
    func getCoverImageIndexWithPriority(product: Product) -> String? {
        var imageListWithPriorityIndex = [ImageWithPriority]()
        guard let formats = product.formats else {
            return nil
        }
        
        for format in formats {
            let coverImage = ImageWithPriority()
            coverImage.coverImage = format.coverImages?[0]
            if let versionTypeCode = format.versionTypeCode {
                coverImage.priorityIndex = versionTypePriority.index(of: versionTypeCode)
            }
            if (coverImage.priorityIndex == -1) {
                coverImage.priorityIndex = versionTypePriority.count - 1;
            }
            imageListWithPriorityIndex.append(coverImage)
        }
        imageListWithPriorityIndex.sort {
            if let first = $0.priorityIndex, let second = $1.priorityIndex {
                return first < second
            }
            return false
        }
        
        print(imageListWithPriorityIndex[0].coverImage)
        return imageListWithPriorityIndex[0].coverImage
        
    }
}

class ImageWithPriority {
    var coverImage: String?
    var priorityIndex: Int?
}
