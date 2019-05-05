//
//  ViewController.swift
//  Path
//
//  Created by Leshya Bracaglia on 4/10/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController: UIViewController {
    
    //This is our map
    @IBOutlet weak var mapView: GMSMapView!
    //private let locationManager = CLLocationManager()
    var locationManager = CLLocationManager()
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
    var geocoder = CLGeocoder()
    let endLatLon = CLLocationCoordinate2DMake(10.8, 90.1);
    
    //This is the cafe button/items
    @IBOutlet weak var cafe: UIView!
    @IBOutlet weak var cafeImage: UIImageView!
    @IBOutlet weak var cafeText: UILabel!
    
    //This is the culture button/items
    @IBOutlet weak var culture: UIView!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var cultureText: UILabel!
    
    //This is the restaurant button/items
    @IBOutlet weak var restaurant: UIView!
    @IBOutlet weak var restaurantText: UILabel!
    @IBOutlet weak var forkImage: UIImageView!
    
    //The start and end text fields, go button
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var startField: UITextField!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    let group = DispatchGroup()
    
    //Our orange color
    var myorange = UIColor(red: 249.0/255.0, green: 156.0/255.0, blue: 8.0/255.0, alpha: 1.0)
    
    //our dark grey color
    var mygrey = UIColor(red: 58.0/255.0, green: 58.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //This is all style***************************
        cafe.layer.borderColor = UIColor.black.cgColor;
        cafe.layer.borderWidth = 2;
        culture.layer.borderColor = UIColor.black.cgColor;
        culture.layer.borderWidth = 2;
        
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 0.25
        topView.layer.shadowOffset = CGSize(width: 0, height: 5)
        topView.layer.shadowRadius = 4
        
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.25
        bottomView.layer.shadowOffset = CGSize(width: 0, height: -5)
        bottomView.layer.shadowRadius = 4
        
        startField.placeholder = "Current Location"
        startField.text = "201 E 2nd Street, New York, NY, 10009"
        startField.layer.borderColor = mygrey.cgColor
        startField.layer.cornerRadius = 5.0
        startField.layer.borderWidth = 2
        endField.placeholder = "Where are you going?"
        endField.text = "180 Orchard Street, New York, NY, 10002"
        endField.layer.borderColor = mygrey.cgColor
        endField.layer.cornerRadius = 5.0
        endField.layer.borderWidth = 2
        //**********************************************
        
        //For map
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //if(locationManager.){
            
       // }
        locationManager.startUpdatingLocation()

        //self.startField.delegate = self;
        //self.endField.delegate = self;
        
        //Starting location
        //let location:CLLocationCoordinate2D = locationManager.location!.coordinate
        //lat = String(location.latitude)
        //long = String(location.longitude)
        //self.reverseGeocodeCoordinate(location)
    }
    
/*When you click button, changes color themes*/
    @IBAction func onCulture(_ sender: Any) {
        //change culture colors to be clicked
        cultureOn();
        //change cafe colors to be unclicked
        cafeOff();
        //change restaurant colors to be unclicked
        restaurantOff()
    }
    
    
    @IBAction func onGo(_ sender: Any) {

        NSLog("1")
        let startAddress = startField.text!;
        let endAddress = endField.text!;
        //var coordinate1a: Double = 0;
        //var coordinate2a: Double = 0;
        //var coordinate2b: Double = 0;
        //let geocoder = CLGeocoder()
         NSLog("2")
        NSLog(startAddress)
        NSLog(endAddress)
        //something after this point
      
        NSLog("yolo")
      
        //.geocodeAddressString
    /*geocoder.geocodeAddressString(startAddress, completionHandler: {(placemarks, error) -> Void in
        NSLog("12")
            if((error) != nil){
                NSLog("hey")
                print("Error", error as Any)
            }
            NSLog("3")
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                coordinate1a = coordinates.latitude
                coordinate1b = coordinates.longitude
                print(coordinate1a);
                print(coordinate1b);
            }
            NSLog("4")
    })*/
        
        NSLog("What the hell")
        
        /*geocoder.geocodeAddressString(endAddress, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                NSLog("ho")
                print("Error", error as Any)
            }
            NSLog("green")
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                coordinate2a = coordinates.latitude
                coordinate2b = coordinates.longitude
                print(coordinate2a);
                print(coordinate2b);
            }
            NSLog("Blue")
        })*/
        NSLog("yghhzz")
        let handler: (Bool) -> Void = { comp in
            if (comp){
                let endLatLon = self.getEnd(endAddress: endAddress)
                print("HEre")
            }
        }
        group.enter()
        let startlatlon = getStart(startAddress: startAddress, onCompletion: handler);
        NSLog("bad")
        group.enter()
        //let endlatlon = getEnd(endAddress: endAddress);
        var marker = GMSMarker(position: startlatlon);
        marker.map = mapView;
        //(coordinate1a, coordinate1b);
       // let endlatlon = CLLocationCoordinate2DMake(21.06282, 26.72283);
        //print(startlatlon.latitude)
        //print(startlatlon.longitude)
        //NSLog("Sigh")
        //print(endLatLon.latitude)
        //print(endLatLon.longitude)
        
        //draw(src: startlatlon, dst: endlatlon)
        //coordinate2a, coordinate2b);
        
        //draw(src: startlatlon, dst: endlatlon);
    }
    
    
    
    func getStart(startAddress: String, onCompletion: (Bool) -> (Void)) -> CLLocationCoordinate2D{
        var coordinate1a: Double = 0;
        var coordinate1b: Double = 0;
        var loc: CLLocationCoordinate2D = (CLLocationCoordinate2DMake(0, 0));
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(startAddress) {
            placemarks, error in
            let placemark = placemarks?.first
            loc = CLLocationCoordinate2DMake(placemark!.location!.coordinate.latitude,
                                             placemark!.location!.coordinate.longitude)
            NSLog("Why does this print here?")
            NSLog(String(loc.latitude));
            //print(coordinate1a);
            //print(coordinate1b);
        }
        //loc = (CLLocationCoordinate2DMake(coordinate1a, coordinate1b))
        NSLog("And this here?")
        NSLog(String(loc.latitude));
        //print(loc.longitude);
        onCompletion(true)
        return loc;
    }

    func getEnd(endAddress: String) -> CLLocationCoordinate2D{
        var coordinate2a: Double = 0;
        var coordinate2b: Double = 0;
        var loc2: CLLocationCoordinate2D = (CLLocationCoordinate2DMake(0, 0));
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(endAddress) {
            placemarks, error in
            let placemark2 = placemarks?.first
            let lat2 = placemark2!.location!.coordinate.latitude
            let lon2 = placemark2!.location!.coordinate.longitude
            coordinate2a = lat2;
            coordinate2b = lon2;
            //print(coordinate2a);
            //print(coordinate2b);
        }
        loc2 = (CLLocationCoordinate2DMake(coordinate2a, coordinate2b))
        return loc2;
    }
    
    @IBAction func onCafe(_ sender: Any) {
        //Change culture to be unclicked
        cultureOff();
        //Change cafe to be clicked
        cafeOn();
        //Change restaurant to be unclicked
        restaurantOff();
    }
    
    
    @IBAction func onRestaurant(_ sender: Any) {
        //Change culture to be unclicked
        cultureOff();
        //Change cafe to be unclicked
        cafeOff();
        //Change restaurant to be clicked
        restaurantOn();
    }
    
    func cultureOn(){
        culture.layer.backgroundColor = myorange.cgColor;
        beerImage.image = UIImage(named: "beer");
        culture.layer.borderColor = myorange.cgColor;
        culture.layer.borderWidth = 0;
        cultureText.textColor = UIColor.black;
    }
    
    func cultureOff(){
        culture.layer.backgroundColor = mygrey.cgColor;
        beerImage.image = UIImage(named: "beer-orange");
        culture.layer.borderColor = UIColor.black.cgColor;
        culture.layer.borderWidth = 2;
        cultureText.textColor = myorange;
    }
    
    func restaurantOn(){
        restaurant.layer.backgroundColor = myorange.cgColor;
        forkImage.image = UIImage(named: "fork");
        restaurant.layer.borderColor = myorange.cgColor;
        restaurant.layer.borderWidth = 0;
        restaurantText.textColor = UIColor.black;
    }
    
    func restaurantOff(){
        restaurant.layer.backgroundColor = mygrey.cgColor;
        forkImage.image = UIImage(named: "fork-orange");
        restaurant.layer.borderColor = UIColor.black.cgColor;
        restaurant.layer.borderWidth = 2;
        restaurantText.textColor = myorange;
    }
    
    func cafeOn(){
        cafe.layer.backgroundColor = myorange.cgColor;
        cafeImage.image = UIImage(named: "coffee-cup");
        cafe.layer.borderColor = myorange.cgColor;
        cafe.layer.borderWidth = 0;
        cafeText.textColor = UIColor.black;
    }
    
    func cafeOff(){
        cafe.layer.backgroundColor = mygrey.cgColor;
        cafeImage.image = UIImage(named: "coffee-cup-orange");
        cafe.layer.borderColor = UIColor.black.cgColor;
        cafe.layer.borderWidth = 2;
        cafeText.textColor = myorange;
    }
    
    //This functions resigns the keyboard when return is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    //Finds the places and places pins on the map
    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        
        //clear map
        mapView.clear()
        
        //Make place marker for every business of this type in this radius
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types:["restaurant"]) { places in
            places.forEach {
                //Create and place marker for each place
                let marker = PlaceMarker(place: $0)
                marker.map = self.mapView
            }
        }
    }//end of fetchnearbyplaces
    
    //Address to CLLocationCoordinate2D object
    func getLocation(from address: String, completion: @escaping (_ location:
        CLLocationCoordinate2D?)-> Void) {
        NSLog("yellow")
        NSLog(address)
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate else {
                    return
            }
            completion(location)
        }
    }
    
/*
    //Gets Route
    func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
        let session = URLSession.shared
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any], let jsonResponse = jsonResult else {
                print("error in JSONSerialization")
                return
            }
            
            guard let routes = jsonResponse["routes"] as? [Any] else {
                return
            }
            
            guard let overview_polyline = routes[0] as? [String: Any] else {
                return
            }
            
            guard let polyLineString = overview_polyline["points"] as? String else {
                return
            }
            
            //Call this method to draw path on map
            self.drawPath(from: polyLineString)
        })
        task.resume()
    }
    
    //Draws path on map
    func drawPath(from polyStr: String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = mapView // Google MapView
    }
    
*/
    /*
    func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
    }
    */
    func draw(src: CLLocationCoordinate2D, dst: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(src.latitude),\(src.longitude)&destination=\(dst.latitude),\(dst.longitude)&sensor=false&mode=walking&key=**AIzaSyBOmX6XIBumnqSiKwjkxzCObUz60sYkgVE**")!
        NSLog("Here")
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        
                        let preRoutes = json["routes"] as! NSArray
                        let routes = preRoutes[0] as! NSDictionary
                        let routeOverviewPolyline:NSDictionary = routes.value(forKey: "overview_polyline") as! NSDictionary
                        let polyString = routeOverviewPolyline.object(forKey: "points") as! String
                        
                        DispatchQueue.main.async(execute: {
                            let path = GMSPath(fromEncodedPath: polyString)
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeWidth = 5.0
                            polyline.strokeColor = UIColor.green
                            polyline.map = self.mapView
                        })
                    }
                    
                } catch {
                    print("parsing error")
                }
            }
        })
        task.resume()
    }
    
    
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        NSLog("1")
        // 1
        let geocoder = GMSGeocoder()
        
        NSLog("2")
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
        NSLog("3")
            // 3
            self.startField.text = lines.joined(separator: "\n")
            
        }
    }
    
}//end of class


// MARK: - CLLocationManagerDelegate
//1
extension ViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            NSLog("Path needs permission to access your location")
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        // 8
        locationManager.stopUpdatingLocation()
    }
}


