//
//  EventDetail.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//


import SwiftUI

struct EventDetail: View {
    @Binding var eventID: Int
    
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var venueStore: VenueStore
    
    var body: some View {
        
        let viewModel = EventDetailViewModel(eventStore: eventStore, eventID: eventID, venueStore: venueStore)
        
        ScrollView {
            VStack {
                ZStack {
                    GeometryReader { geometry in
                        let geometryWidth = geometry.size.width
                        let geometryHeight = geometry.size.height
                        let geometryFrame = geometry.frame(in: .global).minY
                        
                        ZStack {
                            Image(uiImage: viewModel.eventImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometryWidth, height: geometryHeight + geometryFrame)
                                .clipped()
                                .offset(y: -geometryFrame)
                            Rectangle()
                                .frame(width: geometryWidth, height: geometryHeight + geometryFrame)
                                .clipped()
                                .offset(y: -geometryFrame)
                                .opacity(0.6)
                                .foregroundColor(viewModel.eventImageBackground)
                        }
                        
                    }
                    .frame(height: 400)
                    VStack {
                        Text("\(viewModel.convertDate(date: viewModel.currentEvent.date))" + " — " +  "\(viewModel.getVenue().name)")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        Text("\(viewModel.currentEvent.name)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        Text("\(viewModel.getVenue().location)")
                            .foregroundColor(Color.white)
                    }   
                }
                VStack (alignment: .leading){
//                    Text("\(eventID)")
//                    Text("\(viewModel.currentEvent.name)")
                    
                    let adress = "\(viewModel.getVenue().street) \(viewModel.getVenue().location)"
                    
                    Text("Veranstaltungsort")
                        .foregroundColor(.gray)
                        .font(.body)
                        .textCase(.uppercase)
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
                    Text("\(viewModel.getVenue().name)")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                    Text("\(adress)")
                        .foregroundColor(.gray)
                        .tracking(-0.1)
                        .textCase(.uppercase)
                        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    VenueMap(adress: adress)
                    
                    Text("Test")
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

class EventDetailViewModel: ObservableObject {
    
    let eventID: Int
    let eventStore: EventStore
    let venueStore: VenueStore
    
    // Initialization is needed to provide access to event Store methods
    private var _currentEvent: EventDB!
    var currentEvent: EventDB {
        /// If last remaining Event is deleted reinitialize the eventDB
        return _currentEvent ?? EventDB.init()
    }
    
    private var _eventImage: UIImage!
    var eventImage: UIImage {
        return _eventImage
    }
    
    private var _eventImageBackground: Color!
    var eventImageBackground: Color {
        return _eventImageBackground
    }
    
    init(eventStore: EventStore, eventID: Int, venueStore: VenueStore) {
        self.eventID                = eventID
        self.eventStore             = eventStore
        self.venueStore             = venueStore
        self._currentEvent          = self.eventStore.findByID(id: eventID)
        self._eventImage            = self.getEventHeaderImage()
        self._eventImageBackground  = self.generateBackgroundFromImage()
    }
    
    func getEventHeaderImage() -> UIImage {
        return Utilities.helpers.loadImageFromUUID(imageUUID: self.currentEvent.imageUUID)
    }
    
    func generateBackgroundFromImage () -> Color {
        return Color(self.eventImage.averageColor ?? .clear)
    }
    
    func getVenue () -> VenueDB {
        return venueStore.findByID(id: self.currentEvent.venueID) ?? VenueDB()
    }
    
    func convertDate (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd. MMM, yyyy"
        
        return formatter.string(from: date)
    }
    
    
    
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(
            eventID: .constant(3503817091713033700)
        )
    }
}
