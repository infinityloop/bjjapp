//
//  competitorModel.swift
//  bjj
//
//  Created by Kelvin Lau on 2015-02-21.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

import UIKit

class competitorModel: NSObject {
   
    var firstName: NSString?
    var lastName: NSString?
    var birthday:NSDate?
    var age: NSInteger?
    var weight: Float?
    var division: NSString?
    var beltRank: NSString?
    var academy: NSString?
    var location: NSString?
    
    func initWithDictionary(dictionary: NSDictionary) {
        self.firstName = dictionary.stringForKey("first_name")
        self.lastName = dictionary.stringForKey("last_name")
        self.birthday = dictionary.dateForKey("date")
        self.age = dictionary.numberForKey("age").integerValue
        self.weight = dictionary.numberForKey("weight").floatValue
        self.division = dictionary.stringForKey("division")
        self.beltRank = dictionary.stringForKey("belt")
        self.academy = dictionary.stringForKey("academy")
        self.location = dictionary.stringForKey("location")
    }
}
