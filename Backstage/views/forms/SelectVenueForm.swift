

import SwiftUI

struct SelectionItemView: View {

    @Binding var selection: SelectVenueViewModel.Option
    @State var actionText = "Neuen Veranstalter hinzufügen"

    var body: some View{
        VStack {
            Form {
                Section(footer: Text("Here is a detailed description of the setting.")) {
                    ForEach(0 ..< SelectVenueViewModel.Option.allCases.count, id: \.self) { index in

                        HStack{
                            Button(action: {
                                self.selection  = SelectVenueViewModel.Option.allCases[index]
                            }){Text(SelectVenueViewModel.Option.allCases[index].description)}
                            Spacer()
                            if ( self.selection  ==  SelectVenueViewModel.Option.allCases[index] ){
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
