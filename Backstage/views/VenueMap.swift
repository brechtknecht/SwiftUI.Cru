//
//  VenueMap.swift
//  Backstage
//
//  Created by Felix Tesche on 12.01.21.
//

import SwiftUI
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}


struct VenueMap: View {
    @State var adress: String
    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0
    
    var body: some View {
        let coordinates = generateMapRegion()
        
        let markers = [
            Marker(
                location:MapMarker(
                    coordinate:
                        CLLocationCoordinate2D(
                            latitude: coordinates.0,
                            longitude: coordinates.1),
                    tint: .red
                )
            )
        ]
        
        Text("\(adress)")
        
        Map(coordinateRegion: .constant(
                MKCoordinateRegion (
                    center: CLLocationCoordinate2D(
                        latitude: coordinates.0,
                        longitude: coordinates.1
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.01,
                        longitudeDelta: 0.01
                    )
                )
            ),
            annotationItems: markers) { marker in
                marker.location
            }
        .frame(height: 300)
        .cornerRadius(12)
        .padding(16)
    }
    
    
    func generateMapRegion() -> (Double, Double){
        let address = self.adress
        let geoCoder = CLGeocoder()

        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                // handle no location found
                return
            }
            
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
        
        return (self.latitude, self.longitude)
    }
}

//struct VenueMap_Previews: PreviewProvider {
//    static var previews: some View {
//        VenueMap()
//    }
//}
