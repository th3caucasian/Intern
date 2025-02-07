//
//  List.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//

import UIKit
import TinyConstraints

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    private let rowHeight: CGFloat = 55
    private var currentCase: String = "cities"
    private var mainList: [AnyObject] = []
    private var filteredList: [AnyObject] = []
    var searchController: UISearchController!
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(currentCase: String) {
        super.init(nibName: nil, bundle: nil)
        if currentCase != "cities" && currentCase != "crypto" {
            fatalError("Передан неверный параметр")
        }
        self.currentCase = currentCase
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) еще не реализован")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        switch currentCase {
        case "cities":
            setupCitiesList()
        case "crypto":
            setupCryptoList()
        default:
            fatalError("Неверный параметр")
        }
        setupView()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(toggleSearch))
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.backgroundColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        //definesPresentationContext = true
    }
    
    private func setupCitiesList() {
        let jsonReader = JSONReader()
        mainList = jsonReader.loadCitiesFromFile(fileName: "cities") as [AnyObject]
        filteredList = mainList
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        self.title = "Выбор города"
    }

    private func setupCryptoList() {
        self.title = "Выбор криптовалюты"
    }
    
    @objc private func toggleSearch() {
        if navigationItem.searchController == nil {
            navigationItem.searchController = searchController
            navigationItem.title = nil
        }
        else {
            navigationItem.searchController = nil
            navigationItem.title = "Выбор города"
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let test = mainList as! [City]
        if searchText != "" {
            filteredList = test.filter { $0.name.lowercased().contains(searchText.lowercased()) } as [AnyObject]
        }
        else {
            filteredList = mainList
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationItem.searchController != nil ? filteredList.count: mainList.count//mainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch currentCase {
        case "cities":
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            let item = navigationItem.searchController != nil ? filteredList[indexPath.row] as! City : mainList[indexPath.row] as! City
            cell.leftLabel.text = item.abbreviation
            cell.mainLabel.text = item.name
            return cell
        case "crypto":
            fatalError("Не реализовано")
        default:
            fatalError("Неверный параметр")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

