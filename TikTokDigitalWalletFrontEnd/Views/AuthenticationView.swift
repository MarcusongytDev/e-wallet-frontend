//
//  AuthenticationView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 8/9/23.
//

import SwiftUI
import Firebase

let tiktokPink = Color(red: 254/255, green: 44/255, blue: 85/255)
let tiktokAqua = Color(red: 37/255, green: 244/255, blue: 238/255)
let tiktokGray = Color(red: 211/255, green: 211/255, blue: 211/255)

struct AuthenticationView: View {
    
    @State private var isLoggingIn = false
    
    var body: some View {
        if isLoggingIn {
            SignInView(isLoggingIn: $isLoggingIn)
        } else {
            SignUpView(isLoggingIn: $isLoggingIn)
        }
    }
}

struct SignInView: View {
    
    @EnvironmentObject private var authService: AuthService
//    @EnvironmentObject var user: UserViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    @Binding var isLoggingIn: Bool
    
    var body: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [tiktokPink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundColor(Color.white)
                    .font(.system(size:40, weight: .bold, design: .rounded))
                    .offset(x: -95, y: -100)
//                Text("Log In")
//                    .foregroundColor(Color.white)
//                    .font(.system(size:40, weight: .bold, design: .rounded))
//                    .offset(x: -120, y: -100)
                
                Group {
                    TextField("Email", text: $email, prompt: Text("Email").foregroundColor(.white).bold())
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.white).bold())
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                }
                //Log in button
                Button {
                    Task {
                        do {
                            try await authService.login(_: email, password: password)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("Log In")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(tiktokPink)
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:100)
                
                HStack {
                    Text("Don't have an account?")
                        .bold()
                        .foregroundColor(.white)
                    ZStack {
                        Button {
                            isLoggingIn.toggle()
                        } label: {
                            Text("Sign up")
                                .bold()
                                .frame(width: 90, height: 40)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(tiktokPink)
                                )
                        }
                    }
                }
                .offset(y: 110)
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
    
}

struct SignUpView: View {
    
    private let authenticationVM = AuthenticationViewModel()
    
    @EnvironmentObject var authService: AuthService
//    @EnvironmentObject var user: UserViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    
    @Binding var isLoggingIn: Bool
    
    var body: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [tiktokPink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20) {
                Text("Sign Up")
                    .foregroundColor(Color.white)
                    .font(.system(size:40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -70)
                
                Group {
                    //Username not used: DELETE?
                    TextField("Username", text: $username, prompt: Text("Username").foregroundColor(.white).bold())
                        .foregroundColor(.white)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    TextField("First Name", text: $firstName, prompt: Text("First Name").foregroundColor(.white).bold())
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled(true)

                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    TextField("Last Name", text: $lastName, prompt: Text("Last Name").foregroundColor(.white).bold())
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled(true)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    TextField("Email", text: $email, prompt: Text("Email").foregroundColor(.white).bold())
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.white).bold())
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                }
                //Log in button
                Button {
                    Task {
                        do {
                            try await authService.signUp(_: email, password: password, username: username, firstName: firstName, lastName: lastName)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    authenticationVM.SendAddWalletData(userId: authService.user.uuid)
                    
                } label: {
                    Text("Sign Up")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(tiktokPink)
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:100)
                
                HStack {
                    Text("Already have an account?")
                        .bold()
                        .foregroundColor(.white)
                    ZStack {
                        Button {
                            isLoggingIn.toggle()
                        } label: {
                            Text("Log in")
                                .bold()
                                .frame(width: 90, height: 40)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(tiktokPink)
                                )
                        }
                    }
                }
                .offset(y: 110)
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
    
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
