//
//  OnboardingView.swift
//  FaceReality
//
//  Created by Bianca Nathally Bezerra de Lima on 06/09/23.
//

import SwiftUI
import RealityKit
import UserNotifications


struct OnboardingView: View {
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    @State private var isShowingDestinationView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all).blur(radius: 40)
                
                VStack(spacing: 24) {
                    VStack(spacing: 24) {
                        Text("onboardingtitle-string")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .padding(.top, 16)
                        
                        Text("onboardingbody-string")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .padding()
                            .minimumScaleFactor(0.01)
                            .multilineTextAlignment(.center)
                    }
                    
                    Button("onboardingbutton-string") {
                        isShowingDestinationView = true
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 12)
                    .foregroundColor(Color.projectWhite)
                    .background(Color.iconColor)
                    .cornerRadius(20)
                    .padding(.bottom, 16)
                }
                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial).opacity(0.25).shadow(radius: 8, y: 8))
                .padding(.horizontal, 60)
                .padding(.vertical, 250)
                
                if isShowingDestinationView {
                    IntermadiateViewToContent()
                }
                
            }
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct IntermadiateViewToContent: View {
    @State var shouldShow = false
    
    var body: some View {
        if shouldShow {
            ContentView()
        }
        else {
            Text("Loading")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()){
                        self.shouldShow = true
                    }
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
