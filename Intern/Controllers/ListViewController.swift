//
//  List.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//

import UIKit
import TinyConstraints

// Общий контроллер для спика городов и криптовалют (Родительский класс)
class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    private let rowHeight: CGFloat = 55
    private var mainList: [String] = []
    var searchController = UISearchController(searchResultsController: nil)
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupView()
    }
    
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(toggleSearch))
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.backgroundColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func setupList() {
        fatalError("Этот метод должен быть переопределен подклассом")
    }
    
    @objc func toggleSearch() {
        if navigationItem.searchController == nil {
            navigationItem.searchController = searchController
            navigationItem.title = nil
        }
        else {
            navigationItem.searchController = nil
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        fatalError("Этот метод должен быть переопределен подклассом")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = mainList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

