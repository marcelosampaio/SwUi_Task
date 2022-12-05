//
//  ContentView.swift
//  SwUi_Task
//
//  Created by Marcelo Sampaio on 04/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var stock: Stock
    @State var loading = true
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stock.name)
                .bold()
                .font(.title)
            
            if !loading {
                VStack {
                    Spacer()
                        .frame(height: 8)
                    
                    Text("Current: \(formatDouble(value: stock.current))")
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                        .frame(height: 16)
                    
                    Text("High: \(formatDouble(value: stock.high))")
                    Text("Low: \(formatDouble(value: stock.low))")
                }
            }
            
        }.task {
            do {
                if let url = URL(string: Constants.stockURL) {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    stock = try JSONDecoder().decode(Stock.self, from: data)
                    loading = false
                    print(response)
                }
            } catch {
                stock = Stock(high: 0.0, low: 0.0, current: 0.0, name: Constants.loadMessage)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
    }
    
    func formatDouble(value: Double) -> String {
        numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stock: Stock(high: 0.0, low: 0.0, current: 0.0, name: Constants.loadMessage))
    }
}
