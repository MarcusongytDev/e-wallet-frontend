//
//  PaymentAmountInputView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 12/9/23.
//

import SwiftUI

struct PaymentAmountInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var paymentAmount: Int
    private var numberFormatter: NumberFormatter
    

    init(numberFormatter: NumberFormatter = NumberFormatter(), paymentAmount: Binding<Int>) {
        self.numberFormatter = numberFormatter
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.maximumFractionDigits = 2
        self._paymentAmount = paymentAmount
    }
            
    var body: some View {
        VStack(spacing: 20) {
                    
                    Text("Input payment amount")
                        .font(.title)
            
                    
                    CurrencyTextField(numberFormatter: numberFormatter, value: $paymentAmount)
                        .padding(20)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                        .frame(height: 100)
                    
                    Rectangle()
                        .frame(width: 0, height: 40)
                    
                    Text("Confirm")
                        .fontWeight(.bold)
                        .padding(30)
                        .frame(width: 180, height: 50)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
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
        }
}


struct CurrencyTextField: UIViewRepresentable {

    typealias UIViewType = CurrencyUITextField

    let numberFormatter: NumberFormatter
    let currencyField: CurrencyUITextField

    init(numberFormatter: NumberFormatter, value: Binding<Int>) {
        self.numberFormatter = numberFormatter
        currencyField = CurrencyUITextField(formatter: numberFormatter, value: value)
    }

    func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }

    func updateUIView(_ uiView: CurrencyUITextField, context: Context) { }
}

//struct PaymentAmountInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentAmountInputView(paymentAmount: $paymentAmount)
//    }
//}
