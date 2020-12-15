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
    
    var body: some View {
        
        let viewModel = EventDetailViewModel(eventStore: eventStore, eventID: eventID)
        
        ScrollView {
            ZStack {
                GeometryReader { geometry in
                    Image(uiImage: viewModel.getEventHeaderImage())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                }
                .frame(height: 400)
                Text("\(eventID)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        VStack {
            Text("\(eventID)")
            Text("\(viewModel.currentEvent.name)")
        }
    }
}

class EventDetailViewModel: ObservableObject {
    
    let eventID: Int
    let eventStore: EventStore
    
    // Initialization is needed to provide access to event Store methods
    private var _currentEvent: EventDB!
    var currentEvent: EventDB {
        return _currentEvent
    }

    init(eventStore: EventStore, eventID: Int) {
        self.eventID = eventID
        self.eventStore = eventStore
        self._currentEvent = self.eventStore.findByID(id: eventID)
    }
        
    func getEventHeaderImage () -> UIImage {
        return Utilities.helpers.loadImageFromUUID(imageUUID: self.currentEvent.imageUUID)
    }
    
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(
            eventID: .constant(3503817091713033700)
        )
    }
}
