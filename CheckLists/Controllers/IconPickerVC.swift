//
//  IconPickerVC.swift
//  CheckLists
//
//  Created by Saad Sherif on 4/29/21.
//

import UIKit

protocol IconPickerVCDelegate: class {
    func iconPicker(_ picker: IconPickerVC, didPick iconName: String)
}

class IconPickerVC: UITableViewController {
    
    weak var delegate: IconPickerVCDelegate?
    
    let icons = ["No Icon", "Appointments", "Birthday", "Folder", "Drinks", "Inbox", "Photos", "Shopping", "Trips", "Yoga", "Pool", "Shower", "Spa", "Fitness", "Beach"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPick: iconName)
        }
    }
}
