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
    private var mainList: [String] = []
    var searchController: UISearchController!
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) еще не реализован")
    }
    
    // переделать
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
//        switch currentCase {
//        case "cities":
//            setupCitiesList()
//        case "crypto":
//            setupCryptoList()
//        default:
//            fatalError("Неверный параметр")
//        }
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
    
    func setupList() {
        fatalError("Этот метод должен быть переопределен подклассом")
    }
    
    // переделать
//    private func setupCitiesList() {
//        let jsonReader = JSONReader()
//        mainList = jsonReader.loadCitiesFromFile(fileName: "cities") as [AnyObject]
//        filteredList = mainList
//        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
//        self.title = "Выбор города"
//    }
    
    // переделать
//    private func setupCryptoList() {
//        self.title = "Выбор криптовалюты"
//    }
    
    // переделать
    @objc func toggleSearch() {
        if navigationItem.searchController == nil {
            navigationItem.searchController = searchController
            navigationItem.title = nil
        }
        else {
            navigationItem.searchController = nil
//            navigationItem.title = "Выбор города"
        }
    }
    
    // переделать
    func updateSearchResults(for searchController: UISearchController) {
        fatalError("Этот метод должен быть переопределен подклассом")
//        guard let searchText = searchController.searchBar.text else { return }
//        let test = mainList as! [City]
//        if searchText != "" {
//            filteredList = test.filter { $0.name.lowercased().contains(searchText.lowercased()) } as [AnyObject]
//        }
//        else {
//            filteredList = mainList
//        }
//        tableView.reloadData()
    }
    
    // переделать
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList.count
    }
    
    // переделать
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = mainList[indexPath.row]
//        switch currentCase {
//        case "cities":
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
//            let item = navigationItem.searchController != nil ? filteredList[indexPath.row] as! City : mainList[indexPath.row] as! City
//            cell.leftLabel.text = item.abbreviation
//            cell.mainLabel.text = item.name
//            return cell
//        case "crypto":
//            fatalError("Не реализовано")
//        default:
//            fatalError("Неверный параметр")
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

