//
//  Checklist.swift
//  CheckLists
//
//  Created by Saad Sherif on 4/28/21.
//

import UIKit

class Checklist: NSObject, Codable {
    var name: String = ""
    var items = [CheckListItem]()
    var iconName: String = "No Icon"
    
    init(name: String, iconName: String = "No Icon") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    func countUnchekedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
    
//    var count = 0
//    for item in items where !item.checked {
//        count += 1
//    }
//    return count
}
