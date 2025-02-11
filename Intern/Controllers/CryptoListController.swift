    //
    //  CryptoListController.swift
    //  Intern
    //
    //  Created by Алан Эркенов on 07.02.2025.
    //

    import UIKit
    import Moya
    import Kingfisher

    class CryptoListController: ListViewController, UINavigationControllerDelegate {
        
        private var cryptoList: [Crypto] = []
        private var filteredList: [Crypto] = []
        var selectedCrypto: [Crypto] = []
        weak var transmissionDelegate: TransmissionDelegate?
        weak var networkDelegate: NetworkDelegate?
        private var networkError = false
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupList()
        }
        
        override func setupList() {
            networkDelegate?.fetchCrypto { [weak self] cryptos in
                if cryptos == nil {
                    self!.networkError = true
                    self!.transmissionDelegate?.saveCryptoList(cryptoList: nil)
                } else {
                    self!.cryptoList = cryptos!
                    for i in self!.cryptoList.indices {
                        self!.cryptoList[i].id = self!.cryptoList[i].id.prefix(1).uppercased() + self!.cryptoList[i].id.dropFirst()
                    }
                    self!.filteredList = self!.cryptoList
                    self!.tableView.reloadData()
                }
            }
            if let cryptos = UserDefaults.standard.data(forKey: "cryptoList") {
                if let decodedList = try? JSONDecoder().decode([Crypto].self, from: cryptos) {
                    decodedList.forEach { crypto in
                        selectedCrypto.append(crypto)
                        }
                    }
            }
            self.title = "Выбор криптовалюты"
        }
        
        override func updateSearchResults(for searchController: UISearchController) {
            guard let searchText = searchController.searchBar.text else { return }
            if searchText != "" {
                filteredList = cryptoList.filter { $0.id.lowercased().contains(searchText.lowercased()) }
            }
            else {
                filteredList = cryptoList
            }
            tableView.reloadData()
        }
        
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            if self.isMovingFromParent && !networkError {
                transmissionDelegate?.saveCryptoList(cryptoList: selectedCrypto)
                if let cryptosEncoded = try? JSONEncoder().encode(selectedCrypto) {
                    UserDefaults.standard.set(cryptosEncoded, forKey: "cryptoList")
                }
            }
        }
        
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return navigationItem.searchController != nil ? filteredList.count: cryptoList.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let currentList = navigationItem.searchController != nil ? filteredList : cryptoList
            cell.textLabel?.text = currentList[indexPath.row].id
            cell.textLabel?.leftToSuperview(offset: 65)
            cell.textLabel?.heightToSuperview()
            
            
            let checkbox = UIButton()
            checkbox.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.image(for: .normal)?.withTintColor(.gray)
            checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            checkbox.image(for: .selected)?.withTintColor(.systemBlue)
            checkbox.tag = indexPath.row
            checkbox.addTarget(self, action: #selector(checkBoxClicked(_:)), for: .touchUpInside)
     
            
            selectedCrypto.forEach {
                if $0.id == currentList[indexPath.row].id {
                    checkbox.isSelected = true
                }
            }

            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string: filteredList[indexPath.row].image))
            imageView.frame = CGRect(x: 20, y: 10, width: 35, height: 35)
            imageView.contentMode = .scaleAspectFit
            cell.contentView.addSubview(imageView)


            cell.accessoryView = checkbox
            return cell
        }
        
        @objc func checkBoxClicked(_ sender: UIButton) {
            let row = sender.tag
            
            if (sender.isSelected) {
                selectedCrypto.remove(at: selectedCrypto.firstIndex(where: { cryptoList[row].id == $0.id })!)
                sender.isSelected.toggle()
            }
            else if (selectedCrypto.count < 3) {
                    selectedCrypto.append(filteredList[row])
                    sender.isSelected.toggle()
            }
        }
        
        func setupCellCheckBox(_ checkBox: UIButton) {
            if (!checkBox.isSelected) {
                checkBox.isSelected.toggle()
            }
        }
    }
