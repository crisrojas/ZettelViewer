//
//  ViewController.swift
//  ZettelViewer
//
//  Created by Cristian Rojas on 18/08/2020.
//  Copyright © 2020 Cristian Rojas. All rights reserved.
//

import UIKit

class ZettelListViewController: UITableViewController {
    let dataSource = ZettelDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        dataSource.fetch("https://www.crisrojas.com/index.json")
        tableView.dataSource = dataSource
        searchConfig()
    }
}

//MARK: - Search implementation

extension ZettelListViewController: UISearchResultsUpdating {
    
    func searchConfig() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Find a Zettel"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        dataSource.filteredText = searchController.searchBar.text
    }
}

