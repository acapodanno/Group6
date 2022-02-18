import SwiftUI
import MapKit

struct MapView: View
{
    @State var detailViewShown = false
    @StateObject var locationManager = LocationManager()
    
    @State var currItem = MapPoint(name: "", lat: Double(0), long: Double(0))

    /*
     TODO: punti presi da campi 'latitude' e 'longitude' di Report, il nome può essere la via + numero civico o area di interesse (es. campus universitario, palestra, ecc)
     */
    private let places = [
        MapPoint(name: "A point in the campus", lat: 40.771111, long:  14.790556),
        MapPoint(name: "Another different point", lat: 40.7720, long:  14.79051)
    ]
    
    var body: some View
    {
        VStack
        {
            Map(coordinateRegion: $locationManager.region, annotationItems: places)
            {
                place in
                MapAnnotation(coordinate: place.coords)
                {
                    Button(action: {
                        currItem = place
                        detailViewShown.toggle()
                        print("item: \(currItem.name)")
                    })
                    {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                                .foregroundColor(.red)
                    }
                }
            }
        }
        .sheet(isPresented: $detailViewShown, onDismiss: {}) {
            // TODO: add reference to ReportDetailView
            //ReportDetailView(item: $currItem)
        }
    }
}

struct MapView_Previews: PreviewProvider
{
    static var previews: some View
    {
        MapView()
    }
}
