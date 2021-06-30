//
//  CreateNewEvent.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

enum EventType: String, Equatable, CaseIterable {
    case club           = "Clubauftritt"
    case festival       = "Festivalauftritt"
    case tour           = "Tourauftritt"

    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    
    var selected: String {
            switch self {
                case .club      : return "Clubauftritt"
                case .festival  : return "Festivalauftritt"
                case .tour      : return "Tourauftritt"
            }
        }
}

struct CreateNewEvent: View {
    // Navigation Enviroment
    @Environment(\.presentationMode) var presentationMode
    
    // Store Enviroment
    @EnvironmentObject var store : VenueStore
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var teamStore : TeamStore
    
    
    // Reactive Datapoints for the Form
    @State var eventName = ""
    @State var assignedTeam : TeamDB = TeamDB()
    @State var eventDate = Date()
    @State var eventType : EventType = .club
    @State var eventTime = Date()
    @State var eventFee = ""
    @State static var label = "Event hinzufügen"
    
    // UI States
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    // Computed Properties
    @ObservedObject var selectVenueViewModel = SelectVenueViewModel()
    
    @ObservedObject var user : UserDB = realmSync.user
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Allgemeine Informationen")) {
                        TextField("Name", text: $eventName)
                        DatePicker(selection: $eventDate, in: Date()..., displayedComponents: .date) {
                            Text("Datum")
                        }
                        DatePicker("Zeit", selection: $eventTime, displayedComponents: .hourAndMinute)
                        
                        Picker(selection: $eventType, label: Text("")) {
                            ForEach(EventType.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 8)
                    }
                    
                    Section (header: Text("Zugehörige Gruppe")) {
                        Section {
                            Picker("Zugehörige Gruppe", selection: $assignedTeam) {
                                ForEach(user.teams, id: \.self) {
                                    Text($0.name).tag($0)
                                }
                            }
                        }
                    }
                    
                    Section(
                        header: Text("Veranstaltungsbild"),
                        footer: Text("Wenn du kein Veranstaltungsbild auswählst, bekommst du das Standardbild")
                                .padding(.vertical, 8)
                    ) {
                        Button(action: {
                            self.showingImagePicker = true
                        }) {
                            if image != nil {
                                image?
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 250)
                            } else {
                                Text("Bitte Bild auswählen")
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    // Custom Selection scraped from stackoverflow
                    Section(header: Text("Veranstaltungsort")) {
                        NavigationLink(destination:
                                SelectionItemView(
                                    selection: $selectVenueViewModel.selectedOption,
                                    location: $selectVenueViewModel.selectedLocation,
                                    selectedID: $selectVenueViewModel.selectedID
                                )
                        ) {
                            VStack (alignment: .leading) {
                                Text("\(selectVenueViewModel.selectedOption)")
                                    .foregroundColor(ColorManager.primaryDark)
        
                                Text("\(selectVenueViewModel.selectedLocation)")
                                    .foregroundColor(ColorManager.primaryDark)
                                    .font(.body)
                            }.padding(.vertical, 8)
                        }
                    }
                    
                    Section (header: Text("Kosten")) {
                        HStack {
                            TextField("Honorar", text: $eventFee)
                                .keyboardType(.numberPad)
                            Text("€")
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Event erstellen")
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                        // Pop View from Navigation View
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Abbrechen")
                    }
                },
                trailing: HStack {
                    Button(action: {
                        let imageUUID = saveImageAndCreateUUID();
                        
                        let image = Utilities.helpers.loadImageFromUUID(imageUUID: imageUUID.uuidString, compression: 1.0)
                        
                        let color = Color(image.averageColor ?? .clear)
                        
                        let convertedUIColor = UIColor(color)
                        
                        let eventID = UUID().hashValue
                        
                        eventStore.create(
                            id                          : eventID,
                            name                        : eventName,
                            assignedTeam                : assignedTeam,
                            date                        : eventDate,
                            fee                         : Int(eventFee) ?? 0,
                            type                        : eventType.rawValue,
                            venueID                     : selectVenueViewModel.selectedID,
                            imageUUID                   : imageUUID.uuidString,
                            backgroundColorHex          : convertedUIColor.toHexString()
                        )
                        
                        let event = eventStore.findByID(id: eventID)
                        
                        teamStore.addEvent(team: assignedTeam, event: event)
                        
                        // Pop View from Navigation View
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Fertig")
                    }
                })
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
        }
    }
    func loadImage () {
        guard let inputImage = inputImage else { return }
    
        image = Image(uiImage: inputImage)
    }
    
    func saveImageAndCreateUUID () -> UUID {
        let imageData = inputImage?.png() as NSData?
        
        let uuid = UUID()
        
        let documentsPath = Utilities.helpers.getDocumentsDirectory()
        let writePath = documentsPath.appendingPathComponent(uuid.uuidString)
        
        do {
            try imageData?.write(to: writePath, options: .atomic)
        } catch {
            print("Image could not be Saved to Disk")
        }
        
        return uuid
    }
}


class SelectVenueViewModel: ObservableObject {
        @Published var selectedOption: String = "Veranstaltungsort" {
            didSet {
                print("new option selected: \(selectedOption.description)")
            }
        }
    
        @Published var selectedID: Int = 0 {
            didSet {
                print("Venue ID: \(selectedID)")
            }
        }
    
        @Published var selectedLocation: String = "Bitte auswählen" {
            didSet {
                print("new location selected:")
            }
        }
}

struct CreateNewEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewEvent()
    }
}
