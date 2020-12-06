

import SwiftUI

struct SelectionItemView: View {

    @Binding var selection: String
    @State var actionText = "Neuen Veranstalter hinzufügen"
    
    @State var options = ["Test 1", "Test 2", "Test 3"]

    var body: some View{
        VStack {
            Form {
                Section(footer: Text("Here is a detailed description of the setting.")) {
                    ForEach(0 ..< options.count, id: \.self) { index in

                        HStack{
                            Button(action: {
                                self.selection  = options[index]
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
                ButtonFullWidth(label: $actionText);
            }
            .padding(.horizontal, 8)
        }


    }
}
