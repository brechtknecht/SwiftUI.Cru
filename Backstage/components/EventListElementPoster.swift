
//
//  EventListElement.swift
//  Backstage
//
//  Created by Felix Tesche on 02.01.21.
//

import SwiftUI

struct EventListElementPoster: View {
    let viewModel = EventListViewModel()
    
    @State var event: Event
    @State var venue: VenueDB
    
    @EnvironmentObject var eventStore: EventStore
    
    @Environment(\.editMode) var editMode
    
    let CARD_WIDTH : CGFloat = 400
    let CARD_HEIGHT : CGFloat = 500
    
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination:
                EventDetail(
                    eventID: .constant(event.id)
                )
            ) {
                ZStack {
                    let image = Utilities.helpers.loadImageFromUUID(imageUUID: event.imageUUID)
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
                        .cornerRadius(4)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .opacity(isEditing ? 0.4 : 1)
                    Image("PaperTexture")
                        .resizable()
                        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
                        .aspectRatio(1.12, contentMode: .fill)
                        .cornerRadius(4)
                        .blendMode(.multiply)
                        .opacity(isEditing ? 0.4 : 1)
                    Image("EventFrame")
                        .resizable()
                        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
                        .aspectRatio(1.12, contentMode: .fill)
                        .cornerRadius(4)
                        .opacity(isEditing ? 0.15 : 1)
                    
                    VStack (alignment: .center){
                        Text(viewModel.convertDate(date: event.date))
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                            .frame(width: CARD_WIDTH - 20)
                        Spacer()
                        Text(event.name)
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                            .frame(width: CARD_WIDTH - 20)
                        Text(event.type.uppercased())
                            .font(.headline)
                            .fontWeight(.bold)
                            .tracking(2.54)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                            .padding(.vertical, 4)
                            .frame(width: CARD_WIDTH - 20)
                    }
                    .padding(EdgeInsets(top: 32, leading: 12, bottom: 64, trailing: 12))
                }
            }
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
    

//struct EventListElement_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListElement()
//    }
//}
