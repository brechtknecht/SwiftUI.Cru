import SwiftUI

struct SelectionItemView: View {

    @Binding var selection: String
    @Binding var location: String
    @Binding var selectedID: Int
    
    @State var actionText = "Neuen Veranstalter hinzufügen"
    
    @State var addNewVenue = false

    // Import Store to have access to the Data
    @EnvironmentObject var store : VenueStore
    
    // Used for popping Navigation State
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View{
        VStack {
            Form {
                Section(
                    header: Text("VERGANENGE VERANSTALTER"),
                    footer: Text("Here is a detailed description of the setting.")
                ) {
        
                    ForEach(store.venues, id: \.id) { venue in
                        HStack{
                            Button(action: {
                                // Trigger Controller
                                self.selection  = venue.name
                                
                                self.location = venue.location + " " + venue.district + ", " + venue.country
                                
                                self.selectedID = venue.id
                                
                                // Pop Navigation State
                                self.mode.wrappedValue.dismiss()
                                
                            }){
                                VStack (alignment: .leading) {
                                    Text("\(venue.name)")
                                        .foregroundColor(ColorManager.primaryDark)
            
                                    Text("\(venue.location) \(venue.district) \(venue.country)")
                                        .foregroundColor(ColorManager.primaryDark)
                                        .font(.body)
                                }.padding(.vertical, 8)
                            }
                            Spacer()
                            if (self.selection  ==  venue.name){
                                Image(systemName: "checkmark")
                            }
                        }

                    }
                }
            }
            Section {
                Button(action: {
                    self.addNewVenue.toggle()
                }) {
                    ButtonFullWidth(label: $actionText);
                }.sheet(isPresented: $addNewVenue) {
                    AddVenueForm()
                }
                
            }
            .padding(8)
        }
    }
}




