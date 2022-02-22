import Foundation
import CoreLocation
import Combine
import MapKit
import Contacts

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate
{
    private let locationManager = CLLocationManager()
    
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var placeMark: CLPlacemark?
    @Published var region = MKCoordinateRegion()
    @Published var address = ""

    override init()
    {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        lookUpCurrentLocation()
    }
    
    var statusString: String
    {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
            case .notDetermined: return "notDetermined"
            case .authorizedWhenInUse: return "authorizedWhenInUse"
            case .authorizedAlways: return "authorizedAlways"
            case .restricted: return "restricted"
            case .denied: return "denied"
            default: return "unknown"
        }
    }
    
    func lookUpCurrentLocation()
    {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location
        {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler:
            {
                (placemarks, error) in
                if error == nil {
                    self.placeMark = placemarks?[0]
                    let formatter = CNPostalAddressFormatter()
                    if let paddr = self.placeMark?.postalAddress {
                        self.address = formatter.string(from: paddr)
                    }
                }
                else {
                    print("Error converting location")
                }
            })
        }
        else {
            print("Error converting location: no location available")
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        lookUpCurrentLocation()
        
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
            )
        }
    }
}
