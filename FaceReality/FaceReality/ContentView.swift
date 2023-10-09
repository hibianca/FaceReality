//
//  ContentView.swift
//  FaceReality
//
//  Created by Bianca Nathally Bezerra de Lima on 06/09/23.
//

import SwiftUI
import UIKit
import AVFoundation
import Firebase
import FirebaseAnalytics

struct HostingWindowFinder: UIViewRepresentable {
    var callback: (UIWindow?) -> ()
    
    func makeUIView (context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async { [weak view] in
            self.callback (view? .window)
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct ContentView: View {
    @State private var selectedMode: String = ""
    @State private var didTapAR: Bool = false
    @State private var didTap3D: Bool = false
    @State private var showReferences: Bool = false
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all).blur(radius: 40)
                
                HostingWindowFinder { window in
                    Unity.shared.setHostMainWindow(window)
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showReferences = true
                    }
                    print("calling analytics")
                    Analytics.logEvent("info_tap", parameters: ["a": 1])
                    print("calling analytics2")

                }) {
                        Image(systemName: "i.circle")
                            .font(.system(size: 26))
                            .padding(.all)
                            .foregroundColor(.projectWhite)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                

                VStack (spacing: 239) {
                    Text("Face Reality")
                        .font(Font.custom("RedHatDisplayItalic-SemiBold", size: 36))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    VStack(spacing: 56) {
                        Text("selection-string")
                            .font(Font.custom("SF Pro Text", size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        HStack(alignment: .center, spacing: 48) {
                            
                            Button("AR") {
                                selectedMode = "AR"
                                self.didTapAR = true
                                self.didTap3D = false
                            }
                            .buttonStyle(ModeButton())
                            .foregroundStyle(didTapAR ? Color.white : Color.black)
                            .background(didTapAR ? Color(red: 0, green: 0.2, blue: 0.39) : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            Button("3D") {
                                selectedMode = "3D"
                                self.didTap3D = true
                                self.didTapAR = false
                            }
                            .buttonStyle(ModeButton())
                            .foregroundStyle(didTap3D ? Color.white : Color.black)
                            .background(didTap3D ? Color(red: 0, green: 0.2, blue: 0.39) : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        VStack(spacing: 113) {
                            if selectedMode == "" {
                                Text("selection-string")
                                    .padding()
                                    .font(Font.custom("SF Pro Text", size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                
                                Text("")
                                    .padding(.horizontal, 33)
                                    .padding(.vertical, 13)
                                    .font(Font.custom("SF Pro Text", size: 20))
                                    .fontWeight(.medium)
                            }
                            
                            if selectedMode == "AR" {
                                Text("artest-string")
                                    .padding()
                                    .font(Font.custom("SF Pro Text", size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                
                                NavigationLink("start-string", destination: PlayAR(mode: selectedMode).navigationBarBackButtonHidden(true))
                                    .buttonStyle(ButtonStyleSelect())
                                    .disabled(selectedMode.isEmpty)
                            }
                            
                            if selectedMode == "3D" {
                                Text("3dtest-string")
                                    .padding()
                                    .font(Font.custom("SF Pro Text", size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                
                                Button("start-string", action: {
                                    Analytics.logEvent("test_start", parameters: ["a": 1])

                                    Unity.shared.show()
                                })
                                    .buttonStyle(ButtonStyleSelect())
                            }
                        }
                    }
                }
                
                if showReferences {
                    let title = String(localized: "referencestitle-string")
                    let subtitle = String(localized: "referencessubtitle-string")
                    let body = String(localized: "referencesbody-string")
                    VStack(alignment: .leading) {
                        PopupView(dismissAction: {showReferences = false}, titleText: title, subtitleText: subtitle, bodyText: body, isReference: true, buttonLabel: "Fechar", imageIllustration: "")
                            .frame(height: UIScreen.main.bounds.height / 2.7)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonStyleSelect: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 63)
            .padding(.vertical, 13)
            .font(Font.custom("SF Pro Text", size: 12))
            .fontWeight(.semibold)
            .foregroundStyle(.black)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ModeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 33)
            .padding(.vertical, 13)
            .font(Font.custom("SF Pro Text", size: 20))
            .fontWeight(.medium)
    }
}

struct PlayAR: View {
    var mode: String
    
    var body: some View {
        FRContentView()
    }
}
//
