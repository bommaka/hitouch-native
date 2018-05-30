//
//  ProductAPIController.swift
//  Hi-Touch
//
//  Created by Swathi B on 17/04/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit
import Alamofire

class ProductAPIController: UIViewController {
    
    var productList =  [Product]()
    var aggregations: Aggregations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchProducts(with keyword: String,
                        completionHandler: @escaping ([String: AnyObject]?, Error?) -> Swift.Void) {
        guard let userToken =  UserDefaults.standard.string(forKey: userToken) else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization":  userToken,
            ]
        
        let parameters = [
            "keyword": keyword,
            "limit": 10,
            "offset": "",
            "scoreOffset": 0.5,
            "sortCriteria": [
                [
                    "type": "relevance",
                    "order": "desc",
                    "fields": ["_score", "datePublication"]
                ]
            ],
            "outputFields": ["categories", "classifications", "coverImages", "dacKey", "datePublication", "description", "edition", "firstPublishedOn", "formats.bindingStyle", "formats.bindingStyleCode", "formats.coverImages", "formats.datePublication", "formats.isbn13", "formats.isbnPdf", "formats.isbnEpub3", "formats.isbnEpub", "formats.isbnMobi", "formats.licensedEntities", "formats.status", "formats.statusCode", "formats.versionType", "formats.versionTypeCode", "imprint", "isbn13", "meta.abstract", "meta.contributors.originators", "meta.doi", "meta.pdfSize", "meta.span", "meta.subtitle", "meta.title", "originators", "pages", "pdfSize", "subjectGroup", "subtitle", "title"],
            "fieldConfig": [
                [
                    "name": "title",
                    "boost": "50"
                ],
                [
                    "name": "subtitle",
                    "boost": "40"
                ],
                [
                    "name": "dacKey",
                    "boost": "40"
                ],
                [
                    "name": "formats.isbn13",
                    "boost": "40"
                ],
                [
                    "name": "formats.isbnPdf",
                    "boost": "40"
                ],
                [
                    "name": "formats.isbnPdfFree",
                    "boost": "40"
                ],
                [
                    "name": "formats.isbnEpub3",
                    "boost": "40"
                ],
                [
                    "name": "formats.isbnEpub",
                    "boost": "40"
                ],
                [
                    "name": "formats.isbnMobi",
                    "boost": "40"
                ],
                [
                    "name": "formats.isbnDx",
                    "boost": "40"
                ],
                [
                    "name": "formats.classifications.classifications.stringValue",
                    "boost": "40"
                ],
                [
                    "name": "originators.originators.name.last",
                    "boost": "30"
                ],
                [
                    "name": "originators.originators.name.first",
                    "boost": "20"
                ],
                [
                    "name": "originators.originators.name.middle",
                    "boost": "20"
                ],
                [
                    "name": "keywords",
                    "boost": "20"
                ]
            ],
            "filter": [
                "must": [["range": ["datePublication": ["lte": "2020-04-04T23:06:05+05:30"]]], ["nested": [
                    "path": "formats",
                    "query": ["bool": ["must": [["terms": ["  ": ["LFB", "VGR", "PLZ", "IHST", "WNN"]]]]]]
                    ]]],
                "must_not": [],
                "should": [["exists": ["field": "formats.licensedEntities.raw"]], ["nested": [
                    "path": "formats",
                    "query": ["bool": [
                        "must": [["terms": ["formats.statusCode.raw": ["LFB", "VGR", "PLZ", "IHST", "WNN"]]]],
                        "must_not": [["terms": ["formats.classifications.classifications.code.raw": ["DRMY", "EBRRTL"]]]]
                        ]]
                    ]]]
            ],
            "aggs": [
                [
                    "fieldName": "datePublication",
                    "ranges": [
                        [
                            "key": "Older",
                            "to": "2017-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last month",
                            "from": "2018-03-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last 3 months",
                            "from": "2018-01-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last 6 months",
                            "from": "2017-10-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last 12 months",
                            "from": "2017-04-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Upcoming",
                            "from": "2018-04-05T23:06:05+05:30",
                            "to": "2020-04-04T23:06:05+05:30"
                        ]
                    ],
                    "type": "custom_date_range"
                ],
                [
                    "fieldName": "categories.code",
                    "type": "terms"
                ],
                [
                    "fieldName": "imprint",
                    "type": "terms",
                    "limit": 3
                ],
                [
                    "fieldName": "originators.originators.name.full",
                    "type": "terms",
                    "limit": 4
                ],
                [
                    "fieldName": "formats.versionTypeCode",
                    "type": "terms",
                    "limit": 3
                ]
            ],
            "customAggs": [
                "datePublication": ["date_range": [
                    "field": "datePublication",
                    "ranges": [
                        [
                            "key": "Older",
                            "to": "2017-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last month",
                            "from": "2018-03-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last 3 months",
                            "from": "2018-01-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last 6 months",
                            "from": "2017-10-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Last 12 months",
                            "from": "2017-04-05T23:06:05+05:30",
                            "to": "2018-04-05T23:06:05+05:30"
                        ],
                        [
                            "key": "Upcoming",
                            "from": "2018-04-05T23:06:05+05:30",
                            "to": "2020-04-04T23:06:05+05:30"
                        ]
                    ]
                    ]],
                "categoriesCode": ["terms": [
                    "field": "categories.code.raw",
                    "include": [],
                    "size": 0
                    ]],
                "imprint": ["terms": [
                    "field": "imprint.raw",
                    "size": 3
                    ]],
                "originators.originators.name.full": ["terms": [
                    "field": "originators.originators.name.full.raw",
                    "size": 4
                    ]],
                "versionTypeCode": ["terms": [
                    "field": "formats.versionTypeCode.raw",
                    "size": 3
                    ]]
            ]
            ] as [String : Any]
        
        
        Alamofire.request(productSearchURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            print(response)
            print(response.result)
            switch(response.result) {
            case .success(_):
                if let value = response.result.value {
                    print(value)
                    if let jsonArray = value as? [String: AnyObject], let data = jsonArray["data"] as? [String: AnyObject] {
                        completionHandler(data,nil)
                    }
                }
                break
                
            case .failure(_):
                completionHandler(nil,response.result.error)
                break
            }
//            NotificationCenter.default.post(name: .search, object: self.aggregations)

//            self.allProducts(result: response.result, error: response.result.error)
        }
        
    }
    
//    func allProducts(result: Result<Any>, error: Error?) {
//
//    }
}
