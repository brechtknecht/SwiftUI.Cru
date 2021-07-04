//
//  UserCreation.swift
//  Backstage
//
//  Created by Felix Tesche on 04.07.21.
//

import SwiftUI

struct UserCreation: View {
    @State private var username: String = ""
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @EnvironmentObject var userStore : UserStore
    
    var body: some View {
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
        TextField("Enter your name", text: $username)
        Button("Create new User") {
            let id = UUID().hashValue
            // Creates User first to then ref the UserID
            // @Hook:userStore:create
            userStore.create(userID: id, name: username)
            
            realmSync.setCurrentUser(value: id)
            
            let user = userStore.findByID(id: id)
            
            realmSync.setCurrentUserData(user: user ?? UserDB())
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    
    func loadImage () {
        guard let inputImage = inputImage else { return }
    
        image = Image(uiImage: inputImage)
    }
}

struct UserCreation_Previews: PreviewProvider {
    static var previews: some View {
        UserCreation()
    }
}
