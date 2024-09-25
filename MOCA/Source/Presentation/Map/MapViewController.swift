//
//  MapViewController.swift
//  MOCA
//
//  Created by 강석호 on 9/24/24.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var mapView = MKMapView()
    var locationManager = CLLocationManager()
    var searchButton = UIButton()
    var locationButton = UIButton()
    var hasCenteredOnUserLocation = false
    let kakaoApiKey = APIKey.kakaoKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 250/255,
                                       green: 244/255,
                                       blue: 242/255,
                                       alpha: 1)
        setupMapView()
        setupLocationManager()
        setupLocationButton()
        setupSearchButton()
    }
    
    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.none, animated: true)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setupLocationButton() {
        locationButton.setImage(UIImage(systemName: "location"), for: .normal)
        locationButton.tintColor = .white
        locationButton.backgroundColor = .systemBlue
        locationButton.layer.cornerRadius = 25
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationButton)
        
        locationButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(50)
        }
        
        locationButton.addTarget(self, action: #selector(centerToUserLocation), for: .touchUpInside)
    }
    
    private func setupSearchButton() {
        searchButton.setTitle("현재 위치에서 카페 검색", for: .normal)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 10
        searchButton.setTitleColor(.darkGray, for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 14)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.height.equalTo(40)
        }
        
        searchButton.addTarget(self, action: #selector(searchCafes), for: .touchUpInside)
    }
    
    @objc private func searchCafes() {
        let region = mapView.region
        let center = region.center
        let latitudinalMeters = region.span.latitudeDelta * 111000
        let longitudinalMeters = region.span.longitudeDelta * 111000
        
        mapView.removeAnnotations(mapView.annotations)
        
        fetchCafes(lat: center.latitude, lon: center.longitude, radius: min(latitudinalMeters, longitudinalMeters) / 2)
    }
    
    @objc private func centerToUserLocation() {
        guard let userLocation = locationManager.location else { return }
        
        let region = MKCoordinateRegion(center: userLocation.coordinate,
                                        latitudinalMeters: 200,
                                        longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        if !hasCenteredOnUserLocation {
            let region = MKCoordinateRegion(center: userLocation.coordinate,
                                            latitudinalMeters: 200,
                                            longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
            hasCenteredOnUserLocation = true
            
            fetchCafes(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude, radius: 200)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    private func fetchCafes(lat: Double, lon: Double, radius: Double) {
        let urlString = "https://dapi.kakao.com/v2/local/search/category.json?category_group_code=CE7&x=\(lon)&y=\(lat)&radius=\(Int(radius))"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("KakaoAK \(kakaoApiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return
            }
            
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let documents = json["documents"] as? [[String: Any]] {
                    for document in documents {
                        if let placeName = document["place_name"] as? String,
                           let longitude = document["x"] as? String,
                           let latitude = document["y"] as? String,
                           let lat = Double(latitude),
                           let lon = Double(longitude) {
                            let cafeLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                            DispatchQueue.main.async {
                                self.addAnnotationAtCoordinate(coordinate: cafeLocation, title: placeName)
                            }
                        }
                    }
                }
            } catch {
                print("Error parsing cafe data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    private func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}
