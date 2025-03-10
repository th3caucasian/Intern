//
//  CustomCel.swift
//  Intern
//
//  Created by Алан Эркенов on 07.02.2025.
//

import UIKit
import TinyConstraints

class CustomCell: UITableViewCell {
    let leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 20, weight: .light)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [leftLabel, mainLabel].forEach(horizontalStack.addArrangedSubview(_:))
        leftLabel.edgesToSuperview(excluding: [.right], insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        mainLabel.heightToSuperview()
        mainLabel.leftToRight(of: leftLabel, offset: 20)
        contentView.addSubview(horizontalStack)
        horizontalStack.edgesToSuperview()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) еще не реализован" )
    }
}
