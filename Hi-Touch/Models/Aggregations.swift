
import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Aggregations {
	public var originators_name_full : FilterList?
	public var versionTypeCode : FilterList?
	public var datePublication : DatePublication?
	public var categoriesCode : FilterList?
	public var imprint : FilterList?

	required public init?(dictionary: [String: Any]) {

        if let filterDic = dictionary["originators.originators.name.full"] as? [String:AnyObject] { originators_name_full = FilterList(dictionary: filterDic) }
         if let filterDic = dictionary["versionTypeCode"] as? [String:AnyObject] { versionTypeCode = FilterList(dictionary: filterDic) }
         if let filterDic = dictionary["categoriesCode"] as? [String:AnyObject] { categoriesCode = FilterList(dictionary: filterDic) }
         if let filterDic = dictionary["imprint"] as? [String:AnyObject] { imprint = FilterList(dictionary: filterDic) }
        if let datePublicationDic = dictionary["DatePublication"] as? [String:AnyObject] { datePublication = DatePublication(dictionary: datePublicationDic) }
	}
}


public class Buckets {
    public var key : String?
    public var doc_count : Int?
    
    required public init?(dictionary: [String: Any]) {
        key = dictionary["key"] as? String
        doc_count = dictionary["doc_count"] as? Int
    }
}

public class DatePublication {
    public var buckets : [Buckets]?
    
    required public init?(dictionary: [String: Any]) {
        if let bucketsDic = dictionary["buckets"] as? [[String: AnyObject]] {
            let array = bucketsDic.map({ (dict) -> Buckets in
                let buckets = Buckets(dictionary: dict)
                return buckets!
            })
            self.buckets = array
        }
    }
}

public class FilterList {
    public var doc_count_error_upper_bound : Int?
    public var sum_other_doc_count : Int?
    public var buckets : [Buckets]?
    
    required public init?(dictionary: [String: Any]) {
        doc_count_error_upper_bound = dictionary["doc_count_error_upper_bound"] as? Int
        sum_other_doc_count = dictionary["sum_other_doc_count"] as? Int
        if let bucketsDic = dictionary["buckets"] as? [[String: AnyObject]] {
            let array = bucketsDic.map({ (dict) -> Buckets in
                let buckets = Buckets(dictionary: dict)
                return buckets!
            })
            self.buckets = array
        }
    }
}




