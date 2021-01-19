//
//  EventDetail.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//


import SwiftUI


enum ActiveSheet: Identifiable {
    case settlement, transport, contact, addSection
        
    var id: Int {
        hashValue
    }
}


struct EventDetail: View {
    @Binding var eventID: Int
    
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var venueStore: VenueStore
    
    @State var activeSheet: ActiveSheet?
    @State var navigationBarTitleIsShowing : Bool = false
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        
        let viewModel = EventDetailViewModel(eventStore: eventStore, eventID: eventID, venueStore: venueStore)
        
        ScrollView {
            VStack (alignment: .leading, spacing: 0){
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
                    .frame(height: 500)
                    VStack {
                        Text("\(viewModel.convertDate(date: viewModel.currentEvent.date)) — \(viewModel.getType())")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 2)
                        Text("\(viewModel.currentEvent.name)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        Text("\(viewModel.getVenue().name) \(viewModel.getVenue().location)")
                            .foregroundColor(Color.white)
                            .padding(EdgeInsets(top: 2, leading: 32, bottom: 0, trailing: 32))
                            .multilineTextAlignment(.center)
                    }
                }
                VStack (alignment: .leading){
                    
                    let adress = "\(viewModel.getVenue().street) \(viewModel.getVenue().location)"
                    
                    Text("Veranstaltungsort")
                        .foregroundColor(.gray)
                        .font(.body)
                        .textCase(.uppercase)
                        .padding(EdgeInsets(top: 22, leading: 16, bottom: 0, trailing: 16))
                    Text("\(viewModel.getVenue().name)")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                    
                    VenueMap(adress: adress)
                    
                    HStack (spacing: 8) {
                        Button(action: {
                            print("do something!")
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(.white))
                                    .cornerRadius(12)
                                VStack {
                                    Image(systemName: "map.fill")
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                    Text("Route öffnen")
                                }
                                .padding(.vertical, 16)
                            }
                            
                        }
                        Button(action: {
                            print("do something!")
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(.white))
                                    .cornerRadius(12)
                                VStack {
                                    Image(systemName: "phone.fill")
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                    Text("Veranstalter anrufen")
                                }
                                .padding(.vertical, 16)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                    
                }
                .background(ColorManager.backgroundForm)
                
                Settlements(sheetIsActive: $activeSheet, eventID: $eventID)
                
                Transportation(sheetIsActive: $activeSheet, eventID: $eventID)
                
                Contacts(sheetIsActive: $activeSheet, eventID: $eventID)
                
                Button(action: {
                    self.activeSheet = .addSection
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(12)
                        HStack{
                            Text("Neue Sektion hinzufügen")
                                .padding(EdgeInsets(top: 22, leading: 16, bottom: 22, trailing: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(ColorManager.primaryDark)
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding(EdgeInsets(top: 22, leading: 16, bottom: 22, trailing: 16))
                                .foregroundColor(ColorManager.success)
                        }
//                        .frame(width: 250, height: 220)
                    }
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
                .background(ColorManager.backgroundForm)
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(item: $activeSheet) { item in
                switch item {
                case .settlement:
                    
                    let proposedDate = eventStore.findByID(id: eventID)?.date ?? Date()
                    let dayPlusOne = Calendar.current.date(byAdding: .day, value: 1, to: proposedDate)!
                    AddSettlement (
                        settlementArrivalDate: proposedDate,
                        settlementDepartureDate: dayPlusOne,
                        proposedDate: proposedDate,
                        locationService: LocationService(),
                        eventReference: eventID
                    )
                case .transport:
                    AddTransport(
                        sheetHasBeenFinished: .constant(false),
                        eventReference: eventID
                    )
                case .contact:
                    AddPerson(
                        eventReference: eventID
                    )
                case .addSection:
                    AddSection(
                        eventReference: $eventID
                    )
                }
            }
        }
        .navigationBarItems(
            trailing: CEditButton()
        )
        .navigationBarTitle(Text("\(viewModel.currentEvent.name)"))
        .navigationBarTitleDisplayMode(.inline)
                            
        .environment(\.editMode, editMode)
        .coordinateSpace(name: "scroll")
        .background(ColorManager.backgroundForm)

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
        return Utilities.helpers.loadImageFromUUID(imageUUID: self.currentEvent.imageUUID, compression: 0.5)
    }
    
    func generateBackgroundFromImage () -> Color {
        let event = eventStore.findByID(id: self.eventID)
        
        let color = Color(hex: event?.backgroundColorHex ?? "#000000")
        
        return color
    }
    
    func getVenue () -> VenueDB {
        return venueStore.findByID(id: self.currentEvent.venueID) ?? VenueDB()
    }
    
    func getType () -> String {
        return currentEvent.type.uppercased()
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
