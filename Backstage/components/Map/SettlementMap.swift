//
//  SettlementMap.swift
//  Backstage
//
//  Created by Felix Tesche on 12.01.21.
//

import SwiftUI
import MapKit

struct SettlementMarker: Identifiable {
    let id = UUID()
    var location: MapMarker
}


struct SettlementMap: View {
    @State var adress: String
    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0
    
    let MAP_HEIGHT : CGFloat = 300.0
    
    var body: some View {
        let coordinates = generateMapRegion()
        
        let markers = [
            SettlementMarker(
                location:MapMarker(
                    coordinate:
                        CLLocationCoordinate2D(
                            latitude: coordinates.0,
                            longitude: coordinates.1),
                    tint: .red
                )
            )
        ]
        ZStack (alignment: .center){
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
            .frame(width: 250, height: 220)
            .cornerRadius(12)
            .disabled(true)
        }
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
