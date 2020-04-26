//
//  ListStockMapViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ListStockMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var bottomMapConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var mapDetailBottomConstraint: NSLayoutConstraint!
    
    var markers: [MKPointAnnotation] = []
    var depots: [Depot]? = []
    
    var currentPlaceMark: CLPlacemark?
    var currentLine: MKPolyline?
    var currentDepotAnnotation: DepotAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are not enabled")
        }
        
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
        APIClient.getFoodDepots { [weak self] (response) in
            if let _ = response.error {
                return
            }
            self?.depots = response.value
            self?.loadMarkers()
        }
        searchBar.delegate = self
        searchBar.placeholder = "Tìm địa điểm"
        searchBar.resignFirstResponder()
        infoView.isHidden = true
        dismissKey()
    }
    
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(ListStockMapViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func phoneClick(_ sender: Any) {
        if let phone = currentDepotAnnotation?.phone, let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func loadMarkers() {
        var lastLocationPoint: CLLocationCoordinate2D?
        if let depots = depots {
            for depot in depots {
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(depot.latitude), longitude: CLLocationDegrees(depot.longitude))
                lastLocationPoint = location
                // 3)
                let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
                let region = MKCoordinateRegion(center: location, span: span)
                
                mapView.setRegion(region, animated: true)
                
                // 4)
//                let annotation = MKPointAnnotation()
                let annotation = DepotAnnotation(depot: depot, coordinate: location)
//                annotation.coordinate = location
//                annotation.description
//                annotation.title = depot.name
//                annotation.subtitle = depot.provider
                mapView.addAnnotation(annotation)
            }
        }
        // Center map
        if let currentLocation = locationManager.location?.coordinate{
            centerMapOnLocation(location: currentLocation)
        } else {
            if let lastLocationPoint = lastLocationPoint {
                centerMapOnLocation(location: lastLocationPoint)
            }
        }
    }
    
    func highlightCurrentRestaurant() {
        //        for currentMarker in markers {
        //            currentMarker.icon?.tintImage(UIColor.lightGray)
        //            if let currentMarkerData = currentMarker.userData as? Restaurant {
        //                guard let currentRestaurantID = currentRestaurant?.id else {
        //                    self.currentRestaurant = currentMarkerData
        //                    updateBottomData()
        //                    currentMarker.icon?.tintImage(UIColor.orange)
        //                    return
        //                }
        //
        //                if currentMarkerData.id == currentRestaurantID {
        //                    currentMarker.icon?.tintImage(UIColor.orange)
        //                    updateBottomData()
        //                }
        //            }
        //        }
    }
    
    func createPolyline() {
        guard let currentPlacemark = currentPlaceMark?.location?.coordinate, let currentLocaiton = locationManager.location?.coordinate else {
            return
        }
        if let currentLine = currentLine {
            self.mapView.removeOverlay(currentLine)
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentPlacemark, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: currentLocaiton, addressDictionary: nil))
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        
        let directionRequest = MKDirections(request: request)
        directionRequest.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.currentLine = route.polyline
                self.mapView.addOverlay(route.polyline)
                return
            }
        }
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let region = MKCoordinateRegion(center: location, span: span)
        print("locations = \(location.latitude) \(location.longitude)")
        mapView.setRegion(region, animated: true)
    }

    @objc func actionWithParam(){
       print("locations")
    }
}
extension ListStockMapViewController: CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}
extension ListStockMapViewController: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let identifier = "pin"
//
//        if annotation.isKind(of: MKUserLocation.self) {
//            return nil
//        }
//
//        let image = UIImage(named: "car")
////        let button = UIButton(type: .custom)
////        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
////        button.setImage(image, for: .normal)
////        button.addTarget(self, action: #selector(actionWithParam), for: .touchUpInside)
//
////        button.addTarget(self, action: #selector(Map.info(_:)), forControlEvents:UIControlEvents.TouchUpInside)
//
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//        if  annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//            annotationView!.canShowCallout = true
//            annotationView!.image = UIImage(named: "annotation")
////            annotationView!.rightCalloutAccessoryView = button
//        }
//        else {
//            annotationView!.annotation = annotation
//        }
//
//        return annotationView
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let location = view.annotation
        self.currentPlaceMark = MKPlacemark(coordinate: location!.coordinate)

        currentDepotAnnotation = view.annotation as? DepotAnnotation
        nameLabel.text = currentDepotAnnotation?.title
        addressLabel.text = currentDepotAnnotation?.address
        phoneButton.setTitle(currentDepotAnnotation?.phone, for: .normal)
        infoView.isHidden = false
        createPolyline()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("cHere we are")
    }
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("error:: \(error)")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .red
        renderer.lineWidth = 2.0
        return renderer
    }
}
extension ListStockMapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        updateSearchResultsForSearchController(searchText: searchBar.text)
    }
    
    func updateSearchResultsForSearchController(searchText: String?) {
        guard let mapView = mapView,
            let searchBarText = searchText else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, _ in
            guard let response = response else {
                return
            }
            //            self.matchingItems = response.mapItems
            //            self.tableView.reloadData()
            let searchViewController = SearchViewController()
            searchViewController.tableData = response.mapItems
            searchViewController.callback = { [weak self] placemark in
                DispatchQueue.main.async {
                    let center = placemark.coordinate
                    let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    self?.mapView.setRegion(mRegion, animated: true)
                }
            }
            self?.navigationController?.present(searchViewController, animated: true, completion: nil)
        }
    }
}
class DepotAnnotation: NSObject, MKAnnotation {

    var id: String?
    var title: String?
    var address: String?
    var coordinate: CLLocationCoordinate2D
    var provider: String?
    var phone: String?

    init(id: String?, name: String?, address: String?, coordinate: CLLocationCoordinate2D, provider: String?, phone: String?) {
        self.id = id
        self.title = name
        self.address = address
        self.coordinate = coordinate
        self.provider = provider
        self.phone = phone
    }

    init(depot: Depot, coordinate: CLLocationCoordinate2D) {
        self.id = depot.id
        self.title = depot.name
        self.address = depot.address
        self.coordinate = coordinate
        self.provider = depot.provider
        self.phone = depot.phone
    }
}
