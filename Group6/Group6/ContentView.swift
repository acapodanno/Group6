//
//  ContentView.swift
//  Group6
//
//  Created by Alessandro Capodanno on 10/02/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = false

    var body: some View {
        Group{
            if log_Status{
                TabNavigationView()
            } else{
               SplashScreen()
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct SplashScreen: View{
    
    // Animating...
    @State var splashAnimation: Bool = false
    
    @Environment(\.colorScheme) var scheme
    
    @State var removeSplashScreen: Bool = false
    
    var body: some View{
        
        ZStack{
            
            OnBoardingPage()
            // Were going to simply use image for demo purpose....
            
           
            
            
            if !removeSplashScreen{
                
                Color("AccentColor")
                    .mask(
                    
                        // Reverse masking with the help of bending....
                        Rectangle()
                            .overlay(
                            
                                Image("TrashRadarLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .scaleEffect(splashAnimation ? 35 : 1)
                                    .blendMode(.destinationOut)
                            )
                    )
                    .ignoresSafeArea()
            }
        }
        .preferredColorScheme(splashAnimation ? nil : .light)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                
                withAnimation(.easeInOut(duration: 0.4)){
                    splashAnimation.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                    removeSplashScreen = true
                }
            }
        }
    }
}
