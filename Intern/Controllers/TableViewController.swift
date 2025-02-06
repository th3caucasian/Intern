//
//  ScreenSettings.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//

import Foundation
import UIKit

// Здесь используется view внтури класса, чтобы не загромождать проект. В идеале разделять ответственность и view делать как отдельный класс
class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    private var cardList = ["Карта","Погода","Криптовалюты"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.navigationItem.rightBarButtonItem = editButtonItem
    }
    
    func setupView() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isEditing = true
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cardList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = cardList.remove(at: sourceIndexPath.row)
        cardList.insert(movedItem, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
