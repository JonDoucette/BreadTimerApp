//
//  DoublePickerView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/4/24.
//

import SwiftUI

struct DoublePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding public var number: Double
    public var name: String
    public var description: String
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("\(String(format: "%.2f", number)) hours")
                    .padding()
                    .fontWeight(.heavy)
                Text(description)
                    .italic()
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack(){
                    Spacer()
                    VStack{
                        Text("0.5")
                        Stepper("0.5", onIncrement: {
                            number += 0.5
                        }, onDecrement: {
                            if number - 0.5 < 0 {
                                number = 0
                            } else {
                                number -= 0.5
                            }
                        }).labelsHidden()
                    }
                    Spacer()
                    VStack{
                        Text("1")
                        Stepper("1", onIncrement: {
                            number += 1
                        }, onDecrement: {
                            if number - 1 < 0 {
                                number = 0
                            } else {
                                number -= 1
                            }
                        }).labelsHidden()
                    }
                    Spacer()
                    VStack{
                        Text("5")
                        Stepper("5", onIncrement: {
                            number += 5
                        }, onDecrement: {
                            if number - 5 < 0 {
                                number = 0
                            } else {
                                number -= 5
                            }
                        }).labelsHidden()
                    }

                    Spacer()
                }
            }
            .navigationBarTitle(name, displayMode: .inline)
            .navigationBarItems(trailing:
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
        }
    }
}

struct BindingViewExamplePreviewContainer_4: View {
    @State var number = 0.0
    var name = "Bulk Time"
    var description = "The default time used to bulk ferment and let the bread rise."
    
    var body: some View {
        DoublePickerView(number: $number, name: name, description: description)
    }
}

#if DEBUG
struct BindingViewExample_4_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewExamplePreviewContainer_4()
    }
}
#endif

