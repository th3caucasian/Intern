//
//  Untitled.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

import UIKit

class CitiesListController: ListViewController {
    
    private var citiesList: [City] = []
    private var filteredList: [City] = []
    weak var transmissionDelegate: TransmissionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }
    
    override func setupList() {
        citiesList = JSONReader().loadCitiesFromFile(fileName: "cities")
        filteredList = citiesList
        self.title = "Выбор города"
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText != "" {
            filteredList = citiesList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        else {
            filteredList = citiesList
        }
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationItem.searchController != nil ? filteredList.count: citiesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let item = navigationItem.searchController != nil ? filteredList[indexPath.row] : citiesList[indexPath.row]
        cell.leftLabel.text = item.abbreviation
        cell.mainLabel.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = citiesList[indexPath.row]
        transmissionDelegate?.saveCity(city: selectedItem)
        self.navigationController?.popViewController(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
