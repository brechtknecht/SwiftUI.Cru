//
//  CreateNewEvent.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct CreateNewEvent: View {
    // Navigation Enviroment
    @Environment(\.presentationMode) var presentationMode
    
    // Store Enviroment
    @EnvironmentObject var store : VenueStore
    @EnvironmentObject var eventStore: EventStore
    
    // Reactive Datapoints for the Form
    @State var eventName = ""
    @State var eventDate = Date()
    @State var eventType = 0
    @State var eventTime = Date()
    @State var eventFee = ""
    @State static var label = "Event hinzufügen"
    
    // UI States
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    // Computed Properties
    @ObservedObject var selectVenueViewModel = SelectVenueViewModel()
    
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
                        
                        Picker(selection: $eventType, label: Text("What is your favorite color?")) {
                            Text("Clubauftritt").tag(0)
                            Text("Festivalauftritt").tag(1)
                            Text("Tourauftritt").tag(2)
                        }.pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 8)
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
                    
                    
                    Section(header: Text("Logistik und Transport")) {
                        Button(action: {
                            print("Buttontriggag")
                        }) {
                            Text("Fahrzeug auswählen")
                        }
                        Button(action: {
                            print("Buttontriggag")
                        }) {
                            Text("Übernachtung auswählen")
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
                
//                Button(action: {
//                    print("Delete tapped!")
//                }) {
//                    ButtonFullWidth(label: CreateNewEvent.$label)
//                }
//                .padding(8)
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

                        eventStore.create(name: eventName, date: eventDate, venueID: selectVenueViewModel.selectedID, imageUUID: imageUUID.uuidString)
                        
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
