import SwiftUI
import MapKit
import CoreLocation

struct MapView: View
{
    @State var detailViewShown = false
    @State var currItem : ReportModel = ReportModel(id: 0, description: "", status: "", latitude: 0, longitude: 0, createdAt: Date.now)
    @StateObject var locationManager = LocationManager()
    
    var reportApi = ReportApi()
    var reports : [ReportModel] = []
    
    init()
    {
        //reports = reportApi.getAllReport()
    }
    
    var body: some View
    {
        VStack
        {
            Map(coordinateRegion: $locationManager.region, annotationItems: reports)
            {
                report in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: report.latitude, longitude: report.longitude))
                {
                    Button(action: {
                        currItem = report
                        detailViewShown.toggle()
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
            // TODO: serve l'endpoint API "GET single report"
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
