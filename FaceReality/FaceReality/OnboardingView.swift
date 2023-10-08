//
//  OnboardingView.swift
//  FaceReality
//
//  Created by Bianca Nathally Bezerra de Lima on 06/09/23.
//

import SwiftUI
import RealityKit

struct OnboardingView: View {
//    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
//                ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all).blur(radius: 40)
                
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 48) {
                    VStack(spacing: 24) {
                        Text("onboardingtitle-string")
                            .font(.title)
                            .foregroundColor(Color.navyBlue)
                            .padding(.top, 40)
                        
                        Text("onboardingbody-string")
                            .font(.body)
                            .foregroundColor(Color.navyBlue)
                            .padding()
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                            .multilineTextAlignment(.center)
                    }
                    
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), label: {
                        Text("onboardingbutton-string")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 12)
                            .foregroundColor(Color.projectWhite)
                            .background(Color.iconColor)
                            .cornerRadius(20)
                    })
                    .padding(.horizontal, 50)
                    .padding(.bottom, 40)
                    
                }
                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial).opacity(0.9).shadow(radius: 8, y: 8))
                .padding(.horizontal, 60)
                .padding(.vertical, 250)
            }
        }
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
#endif