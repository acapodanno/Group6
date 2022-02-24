//
//  UserProfileView.swift
//  Group6
//
//  Created by Assunta Della Porta on 18/02/22.
//

import SwiftUI


struct UserProfileView: View {
    @State var user : User = UserApi().getUserById(id: UserDefaults.standard.integer(forKey: "userId"))

    var body: some View {
        NavigationView{
            Form {
                ProfileBar(nomeUtente: $user.userName,
                           user: $user)
                Section(header: Text("Badges").font(.title2)) {
                    BadgeListView()
                }
            }
            .navigationTitle(Text("Profile"))
            .navigationBarItems(trailing: NavigationLink(
                destination: SettingsView(user: $user)) {
                    Label("", systemImage: "gear")})
            
             //TODO: dopo aver scelto la foto non si aprono le impostazioni wtf
        }
    }
}

//COMPONENTI

//Immagine, nome, livello e punti
struct ProfileBar : View {
    @Binding var nomeUtente : String
    @Binding var user : User

    var body : some View {
        HStack {  if let image = user.profileImage{
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .overlay(Circle()
                            .stroke(Color.black, lineWidth: 4))
                .padding()
                
            }else{
                
                Image(uiImage: UIImage(named: "profile image")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .overlay(Circle()
                                .stroke(Color.black, lineWidth: 4))
                    .padding()
                    

            }
            VStack {
                Text(user.userName)
                    .font(.title)
                    .bold()
                HStack(spacing: 15) {
                    Text("Liv \(user.level)")
                        .font(.title3)
                        .bold()
                    PointsIcon(punti: user.points)
                }
            }
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

struct BadgeListView : View {
    var body : some View {
        List {
            ForEach(badges) { badge in
                BadgeView(badge: badge)
                    .padding(7)
            }
        }
    }
}


struct BadgeView : View {
    var badge : Badge
    var body : some View {
        HStack(spacing: 40) {
            VStack {
                Image(uiImage: badge.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("\(badge.requiredPoints) pt")
            }
            VStack {
                Text(badge.name)
                    .font(.title2)
            }
        }
    }
}



//PREVIEW
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}



/*
struct BadgeView : Identifiable, View  {
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


//array di priva con i badge
var badgess : [BadgeView] = [
    BadgeView.init(icon:  "heart", description: "cuore"),
    BadgeView.init(icon: "heart.fill", description: "cuore pieno"),
    BadgeView.init(icon: "cart", description: "carrello"),
    BadgeView.init(icon: "cart.fill", description: "carrello pieno"),
    BadgeView.init(icon: "person", description: "user"),
    BadgeView.init(icon:  "heart", description: "cuore1"),
    BadgeView.init(icon: "heart.fill", description: "cuore pieno1"),
    BadgeView.init(icon: "cart", description: "carrello1"),
    BadgeView.init(icon: "cart.fill", description: "carrello pieno1"),
    BadgeView.init(icon: "person", description: "user1")
]
 */
