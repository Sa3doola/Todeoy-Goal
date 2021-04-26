//
//  CheckListItem.swift
//  CheckLists
//
//  Created by Saad Sherif on 4/26/21.
//

import Foundation

class CheckListItem: NSObject, Codable {
    var text: String = ""
    var checked: Bool = false
    
    func toggleChecked() {
        checked = !checked
    }
}
