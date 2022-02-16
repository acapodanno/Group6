
import Foundation
import MapKit

struct MapPoint: Identifiable
{
    let id = UUID()
    var name: String
    var lat: Double
    var long: Double
    
    var coords: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
