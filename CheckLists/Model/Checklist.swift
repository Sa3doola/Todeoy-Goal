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
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
