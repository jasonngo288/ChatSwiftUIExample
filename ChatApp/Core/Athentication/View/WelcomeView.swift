//
//  WelcomeView.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    private let mainScreenBounds: CGRect = UIScreen.main.bounds
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Spacer()
                    Image("welcome-image")
                        .resizable()
                        .frame(width: mainScreenBounds.width - 100, height: mainScreenBounds.width - 100)
                        .scaledToFill()
                    Text("Welcome to WhatsApp")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(getAttriText())
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                        .frame(alignment: .center)
                        .padding(.top, 10)
                    //Text("[Privacy Policy](https://example.com)")
                    NavigationLink {
                        LoginView().navigationBarBackButtonHidden()
                    } label: {
                        Text("Agree & continue")
                            .foregroundColor(.blue)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical)
                    Spacer()
                }
                .font(.subheadline)
                .padding(.top,24)
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .environment(\.openURL, OpenURLAction(handler: { url in
                print(url.absoluteString)
                if url.absoluteString.contains("/privacy") {
                    // action
                }
                
                if url.absoluteString.contains("/terms") {
                    // action
                }
                return .systemAction // change if you want to discard action
            }))
        }
    }
    func getAttriText() -> AttributedString {
        var attriString = AttributedString("Read our Privacy Policy. Tap \"Agree & continue\" to accept the Terms of Service")
        attriString.foregroundColor = .black
        
        if let privacyRange = attriString.range(of: "Privacy Policy") {
          attriString[privacyRange].link = URL(string: "https://www.apple.com/privacy")
          //attriString[privacyRange].underlineStyle = .single
          attriString[privacyRange].foregroundColor = .blue
        }
        
        if let termsRange = attriString.range(of: "Terms of Service") {
          attriString[termsRange].link = URL(string: "https://www.apple.com/terms")
          //attriString[termsRange].underlineStyle = .single
          attriString[termsRange].foregroundColor = .blue
        }
                
        return attriString
      }
}

#Preview {
    WelcomeView()
}
