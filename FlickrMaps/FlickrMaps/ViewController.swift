//
//  ViewController.swift
//  FlickrMaps
//
//  Created by user on 13/02/1444 AH.
//

import UIKit
import GoogleMaps

class ViewController:UIViewController {
    
  
    @IBOutlet weak var myAddress: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
      let myLocation = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myLocation.delegate = self
        myLocation.requestWhenInUseAuthorization()
        myLocation.startUpdatingLocation()
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }


}

extension ViewController : CLLocationManagerDelegate,GMSMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //user real location on the app
        if let location = locations.last{
            let latitdude = location.coordinate.latitude // should use latitude
            let longitdude = location.coordinate.longitude // should use  longitude
            let camera = GMSCameraPosition(latitude: latitdude, longitude: longitdude, zoom: 16.0)
            // update the location
            self.mapView.animate(to: camera)
        }
    }
    // this func show user address
    func  locationTitle(coordinates: CLLocationCoordinate2D){
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinates){
         response , error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            guard
            // this show text address
             let adress = response?.firstResult(),
               let lines = adress.lines
            else{
                return
            }
            self.myAddress.text = lines.joined(separator: "\n")
        }
        
    } // end func
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        locationTitle(coordinates: location)
    } // end func
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let pinMarker = GMSMarker()
        let pinMarkerlatitude = coordinate.latitude
        let pinMarkerlocation = coordinate.longitude
        // this coordinate have a latitude and longitude
        pinMarker.position = coordinate
        pinMarker.title = "Coordinates"
        pinMarker.snippet = "\(pinMarkerlatitude)\n\(pinMarkerlocation)"
        pinMarker.map = mapView
        
    } // end func
    // this func if user  enter the button return  user location
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return false
    }
    
    
    
}

