//
//  PaymentFormView.swift
//  Chapter 25
//
//  Created by mrgsdev on 10.10.2024.
//


import SwiftUI
import SwiftData

struct PaymentFormView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @ObservedObject private var paymentFormViewModel: PaymentFormViewModel
    
    var payment: PaymentActivity?
    
    init(payment: PaymentActivity? = nil) {
        self.payment = payment
        self.paymentFormViewModel = PaymentFormViewModel(paymentActivity: payment)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // Title bar
                HStack(alignment: .lastTextBaseline) {
                    Text("New Payment")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.black)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "multiply")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                }
                
                Group {
                    if !paymentFormViewModel.isNameValid {
                        ValidationErrorText(text: "Please enter the payment name")
                    }
                    
                    if !paymentFormViewModel.isAmountValid {
                        ValidationErrorText(text: "Please enter a valid amount")
                    }
                    
                    if !paymentFormViewModel.isMemoValid {
                        ValidationErrorText(text: "Your memo should not exceed 300 characters")
                    }
                }
             
                // Name field
                FormTextField(name: "Name", placeHolder: "Enter your payment", value: $paymentFormViewModel.name)
                    .padding(.top)
                
                // Type selection
                VStack(alignment: .leading) {
                    Text("TYPE")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                        .padding(.vertical, 10)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            self.paymentFormViewModel.type = .income
                        }) {
                            Text("Income")
                                .font(.headline)
                                .foregroundStyle(self.paymentFormViewModel.type == .income ? Color.white : Color.primary)
                        }
                        .frame(minWidth: 0.0, maxWidth: .infinity)
                        .padding()
                        .background(self.paymentFormViewModel.type == .income ? Color("IncomeCard") : Color(.systemBackground))
                        
                        Button(action: {
                            self.paymentFormViewModel.type = .expense
                        }) {
                            Text("Expense")
                                .font(.headline)
                                .foregroundStyle(self.paymentFormViewModel.type == .expense ? Color.white : Color.primary)
                        }
                        .frame(minWidth: 0.0, maxWidth: .infinity)
                        .padding()
                        .background(self.paymentFormViewModel.type == .expense ? Color("ExpenseCard") : Color(.systemBackground))
                    }
                    .border(Color("Border"), width: 1.0)
                }
                
                // Date and Amount
                HStack {
                    FormDateField(name: "Date", value: $paymentFormViewModel.date)
                    
                    FormTextField(name: "Amount ($)", placeHolder: "0.0", value: $paymentFormViewModel.amount)
                }
                .padding(.top)
                
                // Location
                FormTextField(name: "Location (Optional)", placeHolder: "Where do you spend?", value: $paymentFormViewModel.location)
                    .padding(.top)
                
                // Memo
                FormTextEditor(name: "Memo (Optional)", value: $paymentFormViewModel.memo)
                    .padding(.top)
                
                
                // Save button
                Button(action: {
                    save()
                    dismiss()
                }) {
                    Text("Save")
                        .opacity(paymentFormViewModel.isFormInputValid ? 1.0 : 0.5)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("IncomeCard"))
                        .cornerRadius(10)
                        
                }
                .padding()
                .disabled(!paymentFormViewModel.isFormInputValid)
                
            }
            .padding()
        }
        .keyboardAdaptive()
        
    }
    
    // Save the record using Core Data
    private func save() {
        let newPayment = PaymentActivity(
                            date: paymentFormViewModel.date,
                            name: paymentFormViewModel.name,
                            address: paymentFormViewModel.location,
                            amount: Double(paymentFormViewModel.amount)!,
                            memo: paymentFormViewModel.memo,
                            type: paymentFormViewModel.type)
        
        modelContext.insert(newPayment)
    }
}

#Preview {
    PaymentFormView()
}

struct FormTextField: View {
    let name: String
    var placeHolder: String
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            TextField(placeHolder, text: $value)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding()
                .border(Color("Border"), width: 1.0)
         
        }
    }
}

struct FormDateField: View {
    let name: String
    
    @Binding var value: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            DatePicker("", selection: $value, displayedComponents: .date)
                .accentColor(.primary)
                .padding(10)
                .border(Color("Border"), width: 1.0)
                .labelsHidden()
        }
    }
}

struct FormTextEditor: View {
    let name: String
    var height: CGFloat = 80.0
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            TextEditor(text: $value)
                .frame(minHeight: height)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding()
                .border(Color("Border"), width: 1.0)
        }
    }
}


struct ValidationErrorText: View {

    var iconName = "info.circle"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)

    var text = ""
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)
            
            Spacer()
        }
    }
}
