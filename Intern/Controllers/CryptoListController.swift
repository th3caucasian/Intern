//
//  CryptoListController.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

import UIKit

class CryptoListController: ListViewController {
    
    private var cryptoList: [String] = []
    private var filteredList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }
    
    override func setupList() {
        self.title = "Выбор криптовалюты"
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText != "" {
            filteredList = cryptoList.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        else {
            filteredList = cryptoList
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationItem.searchController != nil ? filteredList.count: cryptoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        return cell
    }
}
