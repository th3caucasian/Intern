//
//  List.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//

import UIKit
import TinyConstraints

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var mainList: [String] = []
    private var citiesList: [City] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupCitiesList()
        setupView()
        
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
    
    private func setupCitiesList() {
        let jsonReader = JSONReader()
        citiesList = jsonReader.loadCitiesFromFile(fileName: "cities")
        citiesList.forEach { mainList.append($0.name) }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.leftLabel.text = citiesList[indexPath.row].abbreviation
        cell.mainLabel.text = citiesList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

