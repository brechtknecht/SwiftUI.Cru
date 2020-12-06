//
//  TryOut.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

//class ViewModel: ObservableObject {
//
//    enum Option: String, Identifiable, CaseIterable, CustomStringConvertible {
//        case optionOne
//        case optionTwo
//        case optionThree
//
//        var id: Option {
//            self
//        }
//
//        var description: String {
//            rawValue.prefix(1).uppercased() + rawValue.dropFirst()
//        }
//    }
//
//    @Published var selectedOption: Option = .optionOne {
//        didSet {
//            print("new option selected: \(selectedOption.description)")
//        }
//    }
//}

//struct TestView: View {
//
//    @ObservedObject var viewModel = ViewModel()
//
//    var body: some View {
//
//        NavigationView {
//            Form {
//                Section() {
//                    NavigationLink(destination: SelectionItemView(selection: $viewModel.selectedOption)) {
//                        Text("Choice")
//                    }
//
//
//                }.navigationBarTitle("Main Screen", displayMode: .inline)
//
//            }.navigationBarTitle(Text("Main Screen"))
//        }
//    }
//}


struct SelectionItemView: View {

    @Binding var selection: SelectVenueViewModel.Option
    @State var actionText = "Veranstaltungsort hinzufügen"
    
    var body: some View{
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
            ButtonFullWidth(label: $actionText);
        }


    }
}
