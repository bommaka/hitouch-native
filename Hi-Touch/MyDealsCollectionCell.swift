//
//  MyDealsCollectionCell.swift
//  Hi-Touch
//
//  Created by Swathi B on 11/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit

class MyDealsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var dealImage: UIImageView!
    @IBOutlet weak var dealName: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var appointmentDate: UILabel!
    @IBOutlet weak var bookCount: UILabel!
    
    func setUp(deal: Deals) {
        if let mediaFile = deal.bundle?.cover {
            let mediaFileChanged = mediaFile.components(separatedBy: ",")
            dealImage.image = UIImage.decodeBase64(toImage: mediaFileChanged.last)
        }
        dealName.text = deal.name
    }
}

extension UIImage {
    
    static func decodeBase64(toImage strEncodeData: String!) -> UIImage {
        
        if let decData = Data(base64Encoded: strEncodeData, options: .init(rawValue: 0) ), strEncodeData.count > 0 {
            return UIImage(data: decData)!
        }
        return UIImage()
    }
}
