

import SwiftUI

struct SelectionItemView: View {

    @Binding var selection: String
    @State var actionText = "Neuen Veranstalter hinzufügen"
    
    @State var options = ["Freddys Rummelbude", "Zirkus Frankenstein", "Marius Olle-GoKartBahn"]
    
    // Used for popping Navigation State
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View{
        VStack {
            Form {
                Section(footer: Text("Here is a detailed description of the setting.")) {
                    ForEach(0 ..< options.count, id: \.self) { index in
                        HStack{
                            Button(action: {
                                // Trigger Controller
                                self.selection  = options[index]
                                
                                // Pop Navigation State
                                self.mode.wrappedValue.dismiss()
                            }){
                                Text(options[index])
                            }
                            Spacer()
                            if ( self.selection  ==  options[index] ){
                                Image(systemName: "checkmark")
                            }
                        }

                    }
                }
            }
            Section {
                Button(action: {
                    print("Ahh Okay!")
                }) {
                    ButtonFullWidth(label: $actionText);
                }
                
            }
            .padding(.horizontal, 8)
        }


    }
}
