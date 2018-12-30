//
//  Item.swift
//  Todoey
//
//  Created by Steve Hsu on 2018/12/29.
//  Copyright © 2018 Steve Hsu. All rights reserved.
//

import Foundation

// the class here with the type "Encodage" means the datas in the class could be encode into the data type of plist or JSON.
// The class here with the type "Decodable" means the datas in the class could be decode from data type like plist or JSON.
// Before we store datas we encode it, and before we retrieve datas we decode it.
class Item: Codable {
    var title : String = ""
    var done : Bool = false
}
