//
//  ZettelDataSource.swift
//  ZettelViewer
//
//  Created by Cristian Rojas on 20/08/2020.
//  Copyright © 2020 Cristian Rojas. All rights reserved.
//

import UIKit

class ZettelDataSource: NSObject, UITableViewDataSource {
    var zettels = [Zettel]()
    var filteredZettels = [Zettel]()
    var dataChanged: (() -> Void)?
    
    var filteredText: String? {
        didSet {
            filteredZettels = zettels.matching(filteredText)
            self.dataChanged?()
        }
    }
    
    func fetch(_ urlString: String) {
        let decoder = JSONDecoder()
        decoder.decode([Zettel].self, fromURL: urlString) { zettels in
            self.zettels = zettels
            self.filteredZettels = zettels
            self.dataChanged?()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredZettels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let zettel = filteredZettels[indexPath.row]
        cell.textLabel?.text = zettel.title
        //cell.detailTextLabel?.text = "\(zettel.id)"
        return cell
    }
    
    
}

