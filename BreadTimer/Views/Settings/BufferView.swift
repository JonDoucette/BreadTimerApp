//
//  BufferView.swift
//  BreadTimer
//
//  Created by Kelsey Doucette on 1/3/24.
//

import SwiftUI

struct BufferView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding public var number: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Buffer Time", selection: $number) {
                    ForEach(0...60, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                .pickerStyle(.wheel)
                .padding()
                Text("\(number) minutes")
                Text("Buffer time (in minutes) will automatically be added between each bread making step.")
                    .italic()
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle("Buffer Settings", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct BufferView_Previews: PreviewProvider {
    @State private static var bufferTime = 5
    static var previews: some View {
        BufferView(number: $bufferTime)
    }
}
