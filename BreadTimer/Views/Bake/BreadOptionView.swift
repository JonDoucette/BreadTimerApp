//
//  BreadOptionView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 12/28/23.
//

import SwiftUI

struct BreadOptionView: View {

    @Binding var baker: BreadHandler

    
    @State private var subtractedDate = Date()
    
    //Enums
    @State private var selectedCommonStretch: CommonStretch = .minute30
    @State private var selectedCommonBulk: CommonBulk = .hour12
    @State private var selectedCommonProof: CommonProof = .hour24
    @State private var selectedCommonOven: CommonOven = .minute45
    
    @State private var accentColor: Color = Color(red:250/255, green: 178/255, blue: 77/255)
    
    
    var body: some View {
        ScrollView {
            VStack(){
                HStack(){
                    VStack(alignment: .leading){
                        Text("Stretch and Fold")
                        Text("in minutes")
                            .italic()
                            .foregroundStyle(.white)
                            .frame(alignment: .leading)
                    }
                    Spacer()
                    Text(String(baker.stretchTime))
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50, alignment: .trailing)
                        .padding(.trailing, 15)
                    Stepper("", onIncrement: {
                        baker.stretchTime += 5
                    }, onDecrement: {
                        if baker.stretchTime - 5 < 0 {
                            baker.stretchTime = 0
                        } else {
                            baker.stretchTime -= 5
                        }
                    })
                    .labelsHidden()
                }.padding(5)
                    .background(accentColor)
                    .cornerRadius(10)
                Spacer()
                Divider()
                HStack(){
                    Text("Intervals")
                        .frame(alignment: .leading)
                    Spacer()
                    Text(String(baker.stretchInterval))
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50, alignment: .trailing)
                    Text("time(s)")
                    Stepper("", onIncrement: {
                        baker.stretchInterval += 1
                    }, onDecrement: {
                        if baker.stretchInterval - 1 < 0 {
                            baker.stretchInterval = 0
                        } else {
                            baker.stretchInterval -= 1
                        }
                    })
                    .labelsHidden()
                }
                .padding(5)
            }.padding(5)
                .background(accentColor)
                .cornerRadius(10)
            VStack(){
                HStack(){
                    VStack(alignment: .leading){
                        Text("Bulk Fermentation")
                        Text("in hours")
                            .italic()
                            .foregroundStyle(.white)
                            .frame(alignment: .leading)
                    }
                    Spacer()
                    Text(String(baker.bulkTime))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50, alignment: .trailing)
                        .padding(.trailing, 15)
                    VStack{
                        Stepper("", onIncrement: {
                            baker.bulkTime += 1
                        }, onDecrement: {
                            if baker.bulkTime - 1 < 0 {
                                baker.bulkTime = 0
                            } else {
                                baker.bulkTime -= 1
                            }
                        })
                        .labelsHidden()
                        HStack(){
                            Button("-0.5"){
                                baker.bulkTime -= 0.5
                            }.foregroundStyle(.black)
                            Divider()
                            Button("+0.5"){
                                baker.bulkTime += 0.5
                            }.foregroundStyle(.black)
                        }

                    }

                }.padding(5)
                    .background(accentColor)
                    .cornerRadius(10)
                Spacer()
                HStack(){
                    Picker("Bulk", selection: $selectedCommonBulk){
                        ForEach(CommonBulk.allCases, id: \.self) { bulk in
                            Text(bulk.rawValue).tag(bulk)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                .onChange(of: selectedCommonBulk) { oldValue, newValue in
                    baker.bulkTime = Double(newValue.number)
                }
                .padding(5)
            }.padding(5)
                .background(accentColor)
                .cornerRadius(10)
            
            VStack(){
                HStack(){
                    VStack(alignment: .leading){
                        Text("Shaping and Proofing")
                        Text("in hours")
                            .italic()
                            .foregroundStyle(.white)
                            .frame(alignment: .leading)
                    }
                    Spacer()
                    Text(String(baker.proofTime))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50, alignment: .trailing)
                        .padding(.trailing, 15)
                    VStack{
                        Stepper("", onIncrement: {
                            baker.proofTime += 1
                        }, onDecrement: {
                            if baker.proofTime - 1 < 0 {
                                baker.proofTime = 0
                            } else {
                                baker.proofTime -= 1
                            }
                        })
                        .labelsHidden()
                        HStack(){
                            Button("-0.5"){
                                baker.proofTime -= 0.5
                            }.foregroundStyle(.black)
                            Divider()
                            Button("+0.5"){
                                baker.proofTime += 0.5
                            }.foregroundStyle(.black)
                        }
                    }
                }
                    .padding(5)
                    .background(accentColor)
                    .cornerRadius(10)
                Spacer()
                Picker("Proof", selection: $selectedCommonProof){
                    ForEach(CommonProof.allCases, id: \.self) { bulk in
                        Text(bulk.rawValue).tag(bulk)
                    }
                }
                    .padding(5)
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectedCommonProof) { oldValue, newValue in
                            baker.proofTime = Double(newValue.number)
                    }
            }.padding(5)
                .background(accentColor)
                .cornerRadius(10)
            
            VStack(){
                HStack(){
                    VStack(alignment: .leading){
                        Text("Oven Time")
                        Text("in minutes")
                            .italic()
                            .foregroundStyle(.white)
                            .frame(alignment: .leading)
                    }
                    Spacer()
                    Text(String(baker.ovenTime))
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50, alignment: .trailing)
                        .padding(.trailing, 15)
                    Stepper("", onIncrement: {
                        baker.ovenTime += 1
                    }, onDecrement: {
                        if baker.ovenTime - 1 < 0 {
                            baker.ovenTime = 0
                        } else {
                            baker.ovenTime -= 1
                        }
                    })
                    .labelsHidden()
                }.padding(5)
                    .background(accentColor)
                    .cornerRadius(10)
                Spacer()
                HStack(){
                    Picker("Oven", selection: $selectedCommonOven){
                        ForEach(CommonOven.allCases, id: \.self) { bulk in
                            Text(bulk.rawValue).tag(bulk)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                .onChange(of: selectedCommonOven) { oldValue, newValue in
                    baker.ovenTime = newValue.number
                }
                .padding(5)
            }.padding(5)
                .background(accentColor)
                .cornerRadius(10)
            DatePicker("Desired Completion: ", selection: $baker.selectedDate, in:Date()...)
                .padding(5)
                .background(accentColor)
                .cornerRadius(10)
        }
    }
}

struct BindingViewExamplePreviewContainer_2: View {
    @State var baker = BreadHandler()

    var body: some View {
        BreadOptionView(baker: $baker)
    }
}

#if DEBUG
struct BindingViewExample_2_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewExamplePreviewContainer_2()
    }
}
#endif



