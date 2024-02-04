//
//  ProfileSearchView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 9/9/23.
//

import SwiftUI

struct ProfileSearchView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var usersLookupVM = UsersLookupViewModel()
    @State var keyword: String = ""
    @Binding var payeeUser: String
    @Binding var payeeUserID: String
    
    var body: some View {
            
            let keywordBinding = Binding<String>(
                get: {
                    keyword
                },
                set: {
                    keyword = $0
                    usersLookupVM.fetchUsers(from: keyword)
                }
            )
            VStack {
                
                Spacer()
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                Text("Back")
                                    .frame(width: 50, height: 40)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                    }
 
                SearchBarView(keyword: keywordBinding)
                ScrollView {
                    ForEach(usersLookupVM.queriedUsers, id: \.uuid) { user in
                        ProfileBarView(payeeUser: $payeeUser, payeeUserID: $payeeUserID, user: user)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    
}

struct SearchBarView: View {
    @Binding var keyword: String
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.5))
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Searching for...", text: $keyword)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}

struct ProfileBarView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var payeeUser: String
    @Binding var payeeUserID: String
    
    var user: User
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray.opacity(1))
            
            HStack {
                
                VStack (alignment: .leading) {
                    Text("\(user.username)")
                        .foregroundColor(.black)
                        .font(.system(size:20, design: .default))
                    Text("\(user.firstName) \(user.lastName)")
                        .foregroundColor(.black)
                        .font(.system(size:20, design: .default))
                }
                Spacer()
                
                Button {
                    payeeUser = user.username
                    payeeUserID = user.uuid
                    dismiss()
                } label: {
                    Text("Add")
                        .frame(width: 50, height: 40)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                        )
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .cornerRadius(13)
        .padding()
    }
}
