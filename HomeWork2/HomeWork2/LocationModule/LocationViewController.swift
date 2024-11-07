//
//  ViewController.swift
//  HomeWork2
//
//  Created by Peter on 27.10.2024.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    //MARK: - Variables
    private var tapCount = 0
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK: - Properties
    private let settingsButton = UIButton(type: .system)
    private let settingsView = UIView()
    private let locationTextView = UITextView()
    private let locationToggle = UISwitch()
    private let locationManager = CLLocationManager()
    private let locationLabel = UILabel()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        setUp()
    }
    
    //MARK: - Setup
    private func setUp() {
        view.backgroundColor = .darkGray
        setUpLocationTextView()
        setUpSettingsView()
        setUpSettingsButton()
        setUpLocationToggle()
        setUpLocationLabel()
    }
    
    private func setUpSettingsButton() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        settingsButton.tintColor = .white
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        view.addSubview(settingsButton)
        settingsButton.setHeight(30)
        settingsButton.setWidth(30)
        settingsButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        settingsButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 15)
    }
    
    @objc
    private func settingsButtonTapped() {
        let vc = SettingsViewController()
        vc.delegate = self
        switch tapCount {
        case 0, 1:
            UIView.animate(withDuration: 0.1) {
                self.settingsView.alpha = 1 - self.settingsView.alpha
            }
        case 2:
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            present(vc, animated: true)
        default:
            tapCount -= 1
        }
        tapCount += 1
        print(tapCount)
    }
    
    private func setUpSettingsView() {
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.backgroundColor = .lightGray
        settingsView.alpha = 0
        view.addSubview(settingsView)
        settingsView.setHeight(300)
        settingsView.setWidth(200)
        settingsView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        settingsView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 10)
    }
    
    private func setUpLocationTextView() {
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        locationTextView.backgroundColor = .white
        locationTextView.layer.cornerRadius = 20
        locationTextView.isUserInteractionEnabled = false
        view.addSubview(locationTextView)
        locationTextView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 60)
        locationTextView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 15)
        locationTextView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 15)
        locationTextView.setHeight(300)
    }
    
    private func setUpLocationToggle() {
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.addTarget(self, action: #selector(locationToggleSwitched), for: .touchUpInside)
        settingsView.addSubview(locationToggle)
        locationToggle.pinTop(to: settingsView.topAnchor, 30)
        locationToggle.pinLeft(to: settingsView.leadingAnchor, 10)
    }
    
    @objc
    private func locationToggleSwitched() {
        if locationToggle.isOn {
            updateLocation()
        } else {
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
    private func updateLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            } else {
                self.locationToggle.setOn(false, animated: true)
            }
        }
    }
    
    private func setUpLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "Location"
        locationLabel.font = .systemFont(ofSize: 14, weight: .medium)
        settingsView.addSubview(locationLabel)
        locationLabel.pinBottom(to: locationToggle.topAnchor, 5)
        locationLabel.pinLeft(to: settingsView.leadingAnchor, 10)
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude), \(coord.longitude)"
    }
}

//MARK: - SettingsViewControllerDelegate
extension LocationViewController: SettingsViewControllerDelegate {
    func toggleSwitch(_ isOn: Bool) {
        if isOn {
            updateLocation()
        } else {
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
}

