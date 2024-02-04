//
//  WalletView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 7/9/23.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject var authService: AuthService
    
    @State private var accNum = ""
    @State private var amount = 0
    @State private var isPopupVisible = false
    
    var WalletBalance = 15.06
    
    let tiktokPink = Color(red: 254/255, green: 44/255, blue: 85/255)
    let tiktokAqua = Color(red: 37/255, green: 244/255, blue: 238/255)
    let tiktokGray = Color(red: 250/255, green: 250/255, blue: 250/255)
    
    let walletVM = WalletViewModel()
    
    @State var numberFormatter: NumberFormatter
    
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
            self.numberFormatter = numberFormatter
            self.numberFormatter.numberStyle = .currency
            self.numberFormatter.maximumFractionDigits = 2
        }
    
    var body: some View {
        ZStack {
            Color.black
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(tiktokPink)
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            Circle()
                .foregroundStyle(.linearGradient(colors: [tiktokAqua], startPoint: .topTrailing, endPoint: .bottomLeading))
                .frame(width: 500)
                .offset(x: -150, y: -360)
            
            Text("\(authService.user.firstName != "" ? "\(authService.user.firstName)".capitalizingFirstLetter() : "User")'s Wallet")
                .foregroundColor(.black)
                .font(.system(size:35 , weight: .bold, design: .rounded))
                .frame(width: 300, height:40, alignment: .topLeading)
                .offset(x: -18, y: -300)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .frame(width: 350, height: 160)
                    .foregroundStyle(tiktokGray)
                VStack {
                    Text("Wallet Balance")
                        .foregroundColor(.black)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .offset(x: -70, y: -18)
                        .frame(width: 350, height: 8)
                    
                    Text("S$\(WalletBalance, specifier: "%.2f")")
                        .foregroundColor(.black)
                        .font(.system(size: 50, weight: .regular, design: .default))
                        .frame(width: 350, height: 50, alignment: .center)
                }
                .frame(width: 350, height: 160, alignment: .leading)
            }
            .offset(y: -140)
            
            HStack {
                //Button shows top up pop up
                Button {
                    //walletVM.SendTopUpWalletData(userId: authService.user.uuid, accNum: accNum, amount: String(amount))
                    isPopupVisible = true
                    
                } label: {
                    Text("Top-up")
                        .bold()
                        .frame(width: 120, height: 40)
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(tiktokAqua)
                        )
                }
                
                .padding()
            
                //withdraw button
                Button {
                    walletVM.SendWithdrawFromWalletData(userId: authService.user.uuid, accNum: accNum, amount: String(amount))
                } label: {
                    Text("Withdraw")
                        .bold()
                        .frame(width: 120, height: 40)
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(tiktokAqua)
                        )
                }
            }
            .offset(y: 10)

        }
        .ignoresSafeArea()
        .onReceive(authService.$uid) { uid in
            if uid != "" {
                Task {
                    do {
                        try await authService.fetchUser()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .overlay(
            isPopupVisible ? PopupView(amount: $amount, numberFormatter: $numberFormatter, isPopupVisible: $isPopupVisible) : nil
        )
    }
}

struct PopupView: View {
    
    @Binding var amount: Int
    @Binding var numberFormatter: NumberFormatter
    @Binding var isPopupVisible: Bool
    
    private let amountLimit = 5
    
    var body: some View {
        // Customize your popup content here
        ZStack {

            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .frame(width: 350, height: 500, alignment: .center)
            
            VStack {
                Spacer()
                Text("Enter Amount:")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .frame(width: 350, height: 8)
                Spacer()
                CurrencyTextField(numberFormatter: numberFormatter, value: $amount)
                    .foregroundColor(.red)
                    .padding(20)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2))
                    .frame(width: 150,height: 60)
                Spacer()
                HStack {
                    Button {
                        amount = 0
                        isPopupVisible.toggle()
                    } label: {
                        Text("Cancel")
                            .bold()
                            .frame(width: 120, height: 40)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(tiktokAqua)
                            )
                    }
                    Button {
                        isPopupVisible.toggle()
                    } label: {
                        Text("Submit")
                            .bold()
                            .frame(width: 120, height: 40)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(tiktokAqua)
                            )
                    }
                }
                Spacer()
            }
            .onChange(of: amount) { newValue in
                if String(newValue).count > amountLimit {
                    amount = Int(String(newValue).prefix(amountLimit))!
                }
            }
        }
        .frame(width: 350, height: 400, alignment: .center)
        .offset(y: 40)
        .onAppear{
            withAnimation(.easeIn(duration: 0.3)) {
                opacity(1.0)
            }
        }
        .onDisappear{
            withAnimation(.easeOut(duration: 0.3)) {
                opacity(0.0)
            }
        }
    }
}


struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
            .environmentObject(AuthService())
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
