//
//  Untitled.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

import UIKit

// Контроллер списка городов
class CitiesListController: ListViewController {
    
    private var citiesList: [City] = []
    private var filteredList: [City] = []
    weak var transmissionDelegate: InfoReceiverDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }
    
    // Читаются данные из локального файла
    override func setupList() {
        citiesList = JSONReader().loadCitiesFromFile(fileName: "cities")
        filteredList = citiesList
        title = ^"cities_list_title"
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            print("Не удалось преобразовать cell в CustomCell")
            return cell
        }
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
