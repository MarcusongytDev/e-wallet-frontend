//
//  ProfileView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 7/9/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var authService: AuthService
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                Text(authService.user.firstName + " " + authService.user.lastName)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 90))
                    
            }
            
            Text("Username: @" + authService.user.username)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.white)
                .padding()
            
            Text("Email: " + authService.user.email)
                .font(.system(size: 20,weight: .regular))
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            HStack {
                Spacer()
                Button() {
                    logout()
                } label: {
                    HStack {
                        Text("Logout")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Image(systemName: "door.left.hand.open")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    .frame(width: 130, height: 40)
                    .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color.gray)
                                            )
                }
            }
            .padding()
        }
        .frame(width: 360, height: 650, alignment: .topLeading)
        .offset(y: 0)
        .padding()
    }
    
    func logout() {
        do {
            try authService.logout()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthService())
    }
}
