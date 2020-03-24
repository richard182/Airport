//
//  ViewController.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

protocol AirportDisplayLogic: class {
    func displayAirports(_ airports: [Airport])
    func displayError(description: String)
}

final class AirportViewController: UIViewController, AirportDisplayLogic {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var searchButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let interactor = AirportInteractor()
    private let presenter = AiportPresenter()
    private let router = AirportRouter()
    private let radius = BehaviorRelay<Int>(value: 1)
    private let longitude = BehaviorRelay<Double?>(value: nil)
    private let coordinates = BehaviorRelay<CLLocationCoordinate2D?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        
        slider
            .rx
            .value
            .observeOn(MainScheduler.instance)
            .map({ Int($0) })
            .subscribe(onNext: { [weak self] (value) in
                self?.distanceLabel.text = String(describing: value)
                self?.radius.accept(value)
            }).disposed(by: disposeBag)
        
        searchButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.getAirports()
            }).disposed(by: disposeBag)
        
        LocationService.shared.delegate = self
        LocationService.shared.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationService.shared.delegate = nil
    }
    
    private func getAirports() {
        guard let coordinates = coordinates.value else { return }
        
        let request = AirportByRadiusRequestModel(radius: radius.value,
                                                  latitude: coordinates.latitude,
                                                  longitude: coordinates.longitude)
        interactor.getWeather(request: request)
    }
    
    func displayAirports(_ airports: [Airport]) {
        router.routeAirportDetails(airports)
    }
    
    func displayError(description: String) {
        let configurationAlert = UIAlertController(title: ":(", message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

        configurationAlert.addAction(okAction)
        present(configurationAlert, animated: true, completion: nil)
    }
}

extension AirportViewController: LocationServiceDelegate {
    
    func tracingLocation(_ currentLocation: CLLocation) {
        guard self.coordinates.value == nil else { return }
        coordinates.accept(currentLocation.coordinate)
    }
    
    func tracingLocationDidFailWithError(_ error: NSError) {
        debugPrint(error)
    }
}
