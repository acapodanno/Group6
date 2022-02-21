//
//  UserProfileView.swift
//  Group6
//
//  Created by Assunta Della Porta on 18/02/22.
//

import SwiftUI


struct UserProfileView: View {
    @State var nomeUtente : String = "Genny"
    @State var isPresented : Bool = false
    @State private var profileImage = UIImage(systemName: "user.fill")!
    
    var body: some View {
        NavigationView{
            Form {
                ProfileBar(isPresented: $isPresented,
                           nomeUtente: $nomeUtente,
                           profileImage: $profileImage)
                Section(header: Text("Badges").font(.title2)) {
                    BadgesList()
                }
            }
            .navigationTitle(Text("Profile"))
            .navigationBarItems(trailing: NavigationLink(
                destination: SettingsView(nomeUtente: $nomeUtente)) {
                    Label("", systemImage: "gear")})
            .sheet(isPresented: $isPresented) {
                PhotoPicker(profileImage: $profileImage) //crea un photoPicker
            }
        }
    }
}

//COMPONENTI

//Immagine, nome, livello e punti
struct ProfileBar : View {
    @Binding var isPresented : Bool
    @Binding var nomeUtente : String
    @Binding var profileImage : UIImage
    
    var body : some View {
        HStack {
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle()
                            .stroke(Color.black, lineWidth: 4))
                .padding()
                .onTapGesture {
                    isPresented = true  //quando si clicca sull'immagine si apre lo sheet col picker
                }
            VStack {
                Text(nomeUtente)
                    .font(.title)
                    .bold()
                HStack(spacing: 15) {
                    Text("Liv 8")
                        .font(.title3)
                        .bold()
                    PointsIcon(punti: 100)
                }
            }
        }
    }
}


//ScrollView con tutti i badge
struct BadgesList : View {
    var layout = [GridItem(.adaptive(minimum: 100))] //la dimensione si adatta allo scherno, la dimensione minima degli elementi è comunque 100
    var body : some View {
        ScrollView {
            LazyVGrid(columns: layout){
                ForEach(badges) { badge in  //badges è un array di badge
                    badge
                        .padding()
                }
            }
        }
    }
}

struct Badge : Identifiable, View  {
    var icon : String
    var description : String
    var id  = UUID()
    var body : some View {
        VStack (spacing: 10){
            Image(systemName: icon)
                .font(.title2)
            Text(description)
        }
    }
}


//rettanglo colorato con i punti
struct PointsIcon : View {
    var punti : Int
    var body : some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 90, height: 60)
            .foregroundColor(.accentColor.opacity(0.7))
            .overlay(Text("\(punti) pt")
                        .font(.title2)
                        .bold())
    }
}


//array di priva con i badge
var badges : [Badge] = [
    Badge.init(icon:  "heart", description: "cuore"),
    Badge.init(icon: "heart.fill", description: "cuore pieno"),
    Badge.init(icon: "cart", description: "carrello"),
    Badge.init(icon: "cart.fill", description: "carrello pieno"),
    Badge.init(icon: "person", description: "user"),
    Badge.init(icon:  "heart", description: "cuore1"),
    Badge.init(icon: "heart.fill", description: "cuore pieno1"),
    Badge.init(icon: "cart", description: "carrello1"),
    Badge.init(icon: "cart.fill", description: "carrello pieno1"),
    Badge.init(icon: "person", description: "user1")
]


struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(nomeUtente: "Genny Savastano")
    }
}
