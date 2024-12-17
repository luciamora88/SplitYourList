//
//  ShoppingListView.swift
//  SplitYourList
//
//  Created by Rathang Pandit on 12/9/24.
//

import SwiftUI

// Modelo para los ítems de la lista
struct ShoppingItem {
    var name: String
    var isChecked: Bool
    var price: Double = 0.00 // Precio ahora es tipo Double
}

// Vista que muestra la lista de compras
struct ShoppingListView: View {
    @State private var items: [ShoppingItem] = []
    @State private var newItemName: String = ""
    @State private var showCodeView: Bool = false
    @State private var uniqueCode: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(items.indices, id: \.self) { index in
                        HStack(spacing: 10) {
                            Toggle(isOn: $items[index].isChecked) {
                                Text(" ") // Espacio para el toggle sin texto
                            }
                            .toggleStyle(CheckBoxToggleStyle())
                            
                            TextField("Add Item", text: $items[index].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            if items[index].price > 0 { // Mostrar el precio solo si es mayor que 0
                                Text(String(format: "$%.2f", items[index].price))
                                    .frame(width: 80, alignment: .leading)
                            }
                            
                            Button(action: {
                                removeItem(at: index)
                            }) {
                                Image(systemName: "trash") // Icono de papelera
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        TextField("New item name", text: $newItemName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Add Item") {
                            let newItem = ShoppingItem(name: newItemName, isChecked: false)
                            items.append(newItem)
                            newItemName = ""
                        }
                        .padding(.leading)
                    }
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: ReceiptView(items: $items)) {
                            Text("Generate List")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button("Send List") {
                            generateUniqueCode()
                            showCodeView = true
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(DefaultButtonStyle())
                    
                    // Mostrar los totales
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Expenses:")
                                .font(.headline)
                            Text(String(format: "$%.2f", totalExpenses()))
                                .font(.title)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Total List Value:")
                                .font(.headline)
                            Text(String(format: "$%.2f", totalListValue()))
                                .font(.title)
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Shopping List")
        }
        .sheet(isPresented: $showCodeView) {
            CodeView(uniqueCode: uniqueCode)
        }
    }
    
    func removeItem(at index: Int) {
        items.remove(at: index)
    }

    func generateUniqueCode() {
        uniqueCode = UUID().uuidString.prefix(8).uppercased()
    }
    
    // Función para calcular el total de los ítems marcados
    func totalExpenses() -> Double {
        return items.filter { $0.isChecked }.reduce(0) { $0 + $1.price }
    }
    
    // Función para calcular el total de la lista completa
    func totalListValue() -> Double {
        return items.reduce(0) { $0 + $1.price }
    }
}

// Nueva vista para mostrar el recibo
struct ReceiptView: View {
    @Binding var items: [ShoppingItem]
    @State private var modifiedItems: [ShoppingItem] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                ForEach(modifiedItems.indices, id: \.self) { index in
                    HStack {
                        Text(modifiedItems[index].name)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        TextField("Price", value: $modifiedItems[index].price, formatter: NumberFormatter.currency)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .padding()

            Button("Submit Changes") {
                submitChanges()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .onAppear {
            self.modifiedItems = items.map { ShoppingItem(name: $0.name, isChecked: $0.isChecked, price: $0.price) }
        }
        .padding()
    }

    func submitChanges() {
        for (index, item) in modifiedItems.enumerated() {
            if index < items.count {
                if item.price >= 0 {
                    items[index].price = item.price
                } else {
                    items[index].price = 0.00
                }
            }
        }
        self.presentationMode.wrappedValue.dismiss() // Volver a la vista principal
    }
}

// Estilo de casilla de verificación
struct CheckBoxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

// Extensión para formato de número
extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

// Vista para mostrar el código único generado
struct CodeView: View {
    let uniqueCode: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text("Operation Successful")
                .font(.title)
                .fontWeight(.bold)

            Text("Code: \(uniqueCode)")
                .font(.title2)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            HStack(spacing: 20) {
                Button("Copy Code") {
                    UIPasteboard.general.string = uniqueCode
                }
                .buttonStyle(DefaultButtonStyle())

                Button("Share") {
                    let activityVC = UIActivityViewController(activityItems: [uniqueCode], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                }
                .buttonStyle(DefaultButtonStyle())
            }

            Spacer()
        }
        .padding()
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
