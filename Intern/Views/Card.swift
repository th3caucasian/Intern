//
//  Card.swift
//  Intern
//
//  Created by Алан Эркенов on 04.02.2025.
//

import UIKit
import TinyConstraints
import MapKit

class Card: UIView {
    
    private var choice = false
    private var buttonsHandlerDelegate: ButtonsHandlerDelegate?
    
    convenience init(delegate: ButtonsHandlerDelegate) {
        self.init()
        buttonsHandlerDelegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "settings")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let choiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.backgroundColor = UIColor(named: "LightBlue")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.15
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let placeholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let defaultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map_bckgrnd")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill  
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 20
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowRadius = 5
        stack.layer.shadowOpacity = 0.5
        stack.layer.shadowOffset = CGSize(width: 0, height: 2)
        stack.layer.masksToBounds = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let upperPlaceholder: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cardText: UILabel = {
        let label = UILabel()
        label.text = "Template"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sepLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    // map view
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.layer.cornerRadius = 20
        return map
    }()
    
    // weather view
    
    // cryptocurrency view
    

    func setupView() {
        self.addSubview(verticalStack)
        verticalStack.widthToSuperview(multiplier: 0.9)
        verticalStack.centerInSuperview()
        verticalStack.addArrangedSubview(upperPlaceholder)
        verticalStack.addArrangedSubview(sepLine)
        verticalStack.addArrangedSubview(placeholder)
        
        upperPlaceholder.addSubview(cardText)
        upperPlaceholder.addSubview(settingsButton)
        upperPlaceholder.widthToSuperview()
        upperPlaceholder.heightToSuperview(multiplier: 0.15)
        
        placeholder.widthToSuperview()
        placeholder.addSubview(defaultImage)
        placeholder.addSubview(choiceButton)
        
        defaultImage.centerInSuperview()
        defaultImage.widthToSuperview(offset: -30)
        
        settingsButton.topToSuperview(offset: 6)
        settingsButton.rightToSuperview(offset: -10)
        
        choiceButton.edgesToSuperview(insets: TinyEdgeInsets(top: 130, left: 100, bottom: 30, right: 100))
        
        cardText.leftToSuperview(offset: 20)
        cardText.topToSuperview(offset: 7)
        
        sepLine.widthToSuperview()
        sepLine.heightToSuperview(multiplier: 0.005)
    }
    
    func setCityCard() {
        choiceButton.addTarget(self, action: #selector(delegateCityChoicePressed), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(delegateCityChoicePressed), for: .touchUpInside)
        cardText.text = "Город"
        defaultImage.image = UIImage(named: "map_bckgrnd")
        
    }
    
    func setWeatherCard() {
        cardText.text = "Погода"
        defaultImage.image = UIImage(named: "weather_bckgrnd")
    }
    
    func setCryptoCard() {
        cardText.text = "Курс криптовалют"
        defaultImage.image = UIImage(named: "crypto_bckgrnd")
    }
    
    @objc func delegateCityChoicePressed() {
        buttonsHandlerDelegate?.cityChoicePressed()
    }
    
    func setCity(latitude: Double, longitude: Double) {
        if (choice == false) {
            choice = true
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            placeholder.addSubview(mapView)
            mapView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude) // Москва
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 50_000, longitudinalMeters: 50_000)
        mapView.setRegion(region, animated: true)
    }

}
