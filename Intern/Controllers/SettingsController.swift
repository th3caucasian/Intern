//
//  ScreenSettings.swift
//  Intern
//
//  Created by Алан Эркенов on 06.02.2025.
//

import UIKit
import TinyConstraints

// Контроллер экрана настроек (перестановка карточек)
class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var transmissionDelegate: InfoReceiverDelegate?
    var cardList: [CardType] = []
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isEditing = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    
    private let wrapperView: UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = .white
        wrapper.layer.cornerRadius = 10
        wrapper.layer.shadowColor = UIColor.black.cgColor
        wrapper.layer.shadowRadius = 5
        wrapper.layer.shadowOpacity = 0.5
        wrapper.layer.shadowOffset = CGSize(width: 0, height: 3)
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        return wrapper
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupView()
        
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        wrapperView.addSubview(tableView)
        tableView.edgesToSuperview()
        view.addSubview(wrapperView)
        wrapperView.height(165)
        wrapperView.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: 30, left: 20, bottom: 490, right: 20), usingSafeArea: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ^"done_order_button", style: .plain, target: self, action: #selector(buttonSavePressed))
    }

    
    
    @objc func buttonSavePressed() {
        transmissionDelegate?.cardOrderChanged(cardsOrder: cardList)
        if let encodedList = try? JSONEncoder().encode(cardList) {
            UserDefaults.standard.set(encodedList, forKey: "cardsOrder")
        }
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ^cardList[indexPath.row].rawValue
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
