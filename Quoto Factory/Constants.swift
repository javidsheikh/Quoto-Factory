//
//  Constants.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 23/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

struct Constants {
    
    struct TheySaidSo {
        static let APIBaseURL = "http://quotes.rest/quote.json"
        static let CategoryExtension = "maxlength=250&category="
        static let APIKey = "api_key=2zU2p77WwotHEbrDYncCfQeF"
    }
    
    struct TheySaidSoParameterKeys {
        static let Length = "maxlength"
        static let Category = "category"
        static let APIKey = "api_key"
    }
    
    struct TheySaidSoParameterValues {
        static let Length = "250"
        static let Category = ""
        static let APIKey = "2zU2p77WwotHEbrDYncCfQeF"
    }
    
    struct TheySaidSoResponseKeys {
        static let Contents = "contents"
        static let Quote = "quote"
        static let Author = "author"
    }
    
}
