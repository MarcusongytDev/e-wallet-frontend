//
//  PaymentsView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 7/9/23.
//

import SwiftUI
import UIKit

struct PaymentsView: View {
    @EnvironmentObject var authService: AuthService
    
    private let paymentsVM = PaymentsViewModel()
    
    @State var paymentView = true
    @State var payeeUser = ""
    @State var payeeUserID = ""
    @State var paymentAmount: Int = 0
    @State var dateFilter = ""
    
    @State var pastTransactionsJSON = [String: String]()
    
    
    let tiktokPink = Color(red: 254/255, green: 44/255, blue: 85/255)
    let tiktokAqua = Color(red: 37/255, green: 244/255, blue: 238/255)
    let tiktokGray = Color(red: 250/255, green: 250/255, blue: 250/255)
    
    private var numberFormatter: NumberFormatter
    
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
            self.numberFormatter = numberFormatter
            self.numberFormatter.numberStyle = .currency
            self.numberFormatter.maximumFractionDigits = 2
        }

    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.black
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [tiktokAqua, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 400, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y: -450)
                VStack {
                    Text("Payments")
                        .foregroundColor(.black)
                        .font(.system(size:40, weight: .bold, design: .rounded))
                        .padding()
                    Spacer(minLength: 18)
                    HStack {
                        //Buttons alternate between pay and view transaction history
                        Button {
                            paymentView = true
                        } label: {
                            Text("Pay")
                                .frame(width: 180, height: 40)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(tiktokPink)
                                )
                        }
                        Button {
                            paymentView = false
                        } label: {
                            Text("View Transaction History")
                                .frame(width: 180, height: 40)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(tiktokPink)
                                )
                        }
                    }
                    Spacer(minLength: 40)
                }
                .frame(width: 380, height: 160)
                .offset(y: -265)
                
                if paymentView == true {
                    VStack () {
                        HStack {
                            Text("Pay to:")
                                .frame(width: 91, height: 40, alignment: .leading)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(tiktokPink)
                                    .frame(width: 220, height: 40)
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                    
                                    NavigationLink(destination: ProfileSearchView(payeeUser: $payeeUser, payeeUserID: $payeeUserID)) {
                                        
                                        if (payeeUser != "") {
                                            Text("\(payeeUser)")
                                                .frame(width: 150, height: 40)
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                        } else {
                                            Text("Search for a User")
                                                .frame(width: 150, height: 40)
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .frame(width: 220, height: 40)
                            }
                        }.padding()
                        
                        HStack {
                            Text("Payment Amount:")
                                .frame(width: 160, height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding()
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .fill(tiktokAqua)
                                        .frame(width: 153, height: 68)
                                    NavigationLink(destination: PaymentAmountInputView(paymentAmount: $paymentAmount)) {
                                        Text("Enter here")
                                            .frame(width: 150, height: 20)
                                            .font(.system(size: 18))
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 150, height: 60)
                                }
                        }
                        .padding()
                        
                        Text("Paying S$\(String(format: "%.2f", Double(paymentAmount) / 100)) to \(payeeUser).")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(30)
                        
                        Button {
                            Task {
                                paymentsVM.SendTransactionData(senderId: authService.user.uuid, receiverId: payeeUserID, amount: String(paymentAmount))
                            }
                        } label: {
                            Text("Pay")
                                .frame(width: 180, height: 55)
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .fill(tiktokPink)
                                )
                        }
                        .padding(25)
                        
                    }
                    .frame(width: 400, height: 450)
//                    .border(.green)
                    .offset(y: 60)
                    
                } else {
                    
                    VStack {
                        HStack {
                            Button {
                                dateFilter = "1-day"
                            } label: {
                                Text("Today")
                                    .frame(width: 110, height: 50)
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .background(
                                        Rectangle()
                                            .fill(.gray)
                                    )
                            }
                            Button {
                                dateFilter = "7-days"
                            } label: {
                                Text("This Week")
                                    .frame(width: 110, height: 50)
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .background(
                                        Rectangle()
                                            .fill(.gray)
                                    )
                            }
                            Button {
                                dateFilter = "1-month"
                            } label: {
                                Text("This Month")
                                    .frame(width: 110, height: 50)
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .background(
                                        Rectangle()
                                            .fill(.gray)
                                    )
                            }
                        }
                        
                        ScrollView {
                            //to contain the transaction history
                        }

                    }
                    .frame(width: 400, height: 450)
//                    .border(.green)
                    .offset(y: 60)
                }
            }
            .ignoresSafeArea()
        }
    }
}

//
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//
//}

struct TransactionHistoryView: View {
    
//    var user: User
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray.opacity(1))
            
            HStack {
                
                VStack (alignment: .leading) {
                    Text("Transaction ID")
                        .foregroundColor(.black)
                        .font(.system(size:20, design: .default))
                    Text("Date")
                        .foregroundColor(.black)
                        .font(.system(size:20, design: .default))
                }
                Spacer()
                Text("Paid xxx to @xxx")
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .cornerRadius(13)
        .padding()
    }
}


struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
    }
}
