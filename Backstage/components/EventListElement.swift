
//
//  EventListElement.swift
//  Backstage
//
//  Created by Felix Tesche on 02.01.21.
//

import SwiftUI

struct EventListElement: View {
    
    @State var event: Event
    @State var venue: VenueDB
    
    @EnvironmentObject var eventStore: EventStore
    
    @Environment(\.editMode) var editMode
    
    let CARD_WIDTH : CGFloat = 400
    let CARD_HEIGHT : CGFloat = 500
    
    @ObservedObject var viewModel = ViewModel()
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination:
                EventDetail(
                    eventID: .constant(event._id)
                ).environmentObject(ChecklistStore(realm: RealmPersistent.initializer()))
            ) {
                ZStack {
                 
                    Rectangle()
                        .fill(ColorManager.primaryLight)
                        .cornerRadius(12)
                    
                 
                        VStack {
                            VStack {
                                HStack {
                                    DateTag(date: event.date)
                                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                                        .padding(.all, 8.00)
                                    VStack (alignment: .center) {
                                        HStack {
                                            Text(event.name)
                                                .font(.title)
                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(ColorManager.responsiveBlack)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        HStack {
                                            AttendantsSmall(attendants: event.attendants)
                                                .frame(maxHeight: 28.00)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            TeamIcon(teamName: event.assignedTeam.name, cornerRadius: "bottom")
                        }
                        .addBorder(Color.black.opacity(0.15), width: 0.5, cornerRadius: 12)
                        .shadow(color: Color(red: 0.00, green: 0.00, blue: 0.00).opacity(0.15),
                                 radius: 8.68, x: 0.00, y: 7.35)
                }
                .padding(EdgeInsets(top: 8.00, leading: 12, bottom: 8.00, trailing: 12))

            }
            .buttonStyle(PlainButtonStyle())
            if (isEditing) {
                HStack {
                    Button(action: {
                        print("Edit Event")
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(Color(.systemBlue))
                                .cornerRadius(4)
                            Text("Bearbeiten")
                                .frame(width: (CARD_WIDTH / 2) - 4, height: 42)
                                .foregroundColor(.white)
                        }
                        
                    }
                    Button(action: {
                        deleteEventByID(id: event.id)
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(Color(.red))
                                .cornerRadius(4)
                            Text("Löschen")
                                .frame(width: (CARD_WIDTH / 2) - 4, height: 42)
                                .foregroundColor(.white)
                        }
                        
                    }
                }
            }
        }
        .modifier(ToggleEditModeEffect(y: isEditing ? -10 : 0).ignoredByLayout())
        .contextMenu {
            Button(action: {
                deleteEventByID(id: event.id)
            }) {
                Text("Löschen")
                    .foregroundColor(.red)
                }
            }
        }
    
    
    struct ToggleEditModeEffect: GeometryEffect {
        var y: CGFloat = 0
        
        var animatableData: CGFloat {
            get { y }
            set { y = newValue }
        }
        
        func effectValue(size: CGSize) -> ProjectionTransform {
            return ProjectionTransform(CGAffineTransform(translationX: 0, y: y))
        }
    }
    
    
    private func deleteEventByID(id: Int) {
        print("IndexSet : \(id)")
        eventStore.deleteWithID(id: id)
    }
}

extension EventListElement {
    class ViewModel : ObservableObject {
        @Published var compressedImage : UIImage
        
        init() {
            self.compressedImage = UIImage()
        }
        
        func venueString (venue: VenueDB?) -> String {
            let venueName = venue!.name
            let venueLocation = venue!.location
            let venueDistict = venue!.street
            let venueCountry = venue!.country
            
            return venueName + ", " + venueLocation + " — " + venueDistict + " " + venueCountry
        }
    }
}

    

//struct EventListElement_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListElement()
//    }
//}
