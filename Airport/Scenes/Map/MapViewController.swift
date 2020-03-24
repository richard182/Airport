//
//  MapViewController.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

final class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let disposeBag = DisposeBag()
    private let coordinate = BehaviorRelay<CLLocationCoordinate2D?>(value: nil)
    
    var airports: [Airport] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTranslucentNavigationBar()
        coordinate.accept(LocationService.shared.currentLocation?.coordinate)
        
        coordinate
            .observeOn(MainScheduler.instance)
            .asObservable()
            .bind { [weak self] location in
                guard let coordinate = location else { return }
                self?.centerMapRegion(withCoordinate: coordinate)
        }.disposed(by: disposeBag)
        
        _ = airports.map { [weak self] airport in
            self?.annotationSetup(withAirport: airport)
        }
    }
    
    private func centerMapRegion(withCoordinate coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        let adjustedRegion = mapView.regionThatFits(region)
        self.mapView.setRegion(adjustedRegion, animated: true)
    }
    
    private func annotationSetup(withAirport airport: Airport) {
        let annotation: AirportAnnotation = AirportAnnotation(coordinate: airport.location,
                                                              name: airport.name,
                                                              address: airport.cityName,
                                                              id: airport.airportID)
        self.mapView.addAnnotation(annotation)
    }
}
