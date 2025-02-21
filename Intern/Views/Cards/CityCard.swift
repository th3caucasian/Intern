//
//  CityCard.swift
//  Intern
//
//  Created by Алан Эркенов on 17.02.2025.
//

import MapKit
import TinyConstraints

class CityCard: Card {
        
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.layer.cornerRadius = 20
        return map
    }()
    
    override func setupView() {
        super.setupView()
        cardText.text = "Город"
        defaultImage.image = UIImage(named: "map_bckgrnd")
        cardType = .city
    }
    
    
    // Вызывается при установке города карты
    func setCity(latitude: Double, longitude: Double) {
        if (choice == false) {
            choice = true
            choiceButton.isHidden = true
            defaultImage.isHidden = true
            placeholder.addSubview(mapView)
            mapView.edgesToSuperview(insets: TinyEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 20_000, longitudinalMeters: 20_000)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
}
