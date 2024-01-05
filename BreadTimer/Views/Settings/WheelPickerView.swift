//
//  WheelPicker.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/3/24.
//

import SwiftUI

struct WheelPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding public var number: Int
    var title: String
    var description: String
    var descriptor: String
    var min: Int
    var max: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Buffer Time", selection: $number) {
                    ForEach(Array(min...max), id: \.self) { value in
                        Text("\(value)")
                    }
                }
                .pickerStyle(.wheel)
                .padding()
                Text("\(number) \(descriptor)")
                Text(description)
                    .italic()
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle(title, displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct BindingViewExamplePreviewContainer_3: View {
    @State var number = 0

    var body: some View {
        WheelPickerView(number: $number, title: "Testing", description: "Default time used for Stretching and Folding", descriptor: "minutes", min: 50, max:100)
    }
}

#if DEBUG
struct BindingViewExample_3_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewExamplePreviewContainer_3()
    }
}
#endif

