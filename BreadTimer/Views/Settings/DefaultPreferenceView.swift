//
//  DefaultPreferenceView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/3/24.
//

import SwiftUI

struct DefaultPreferenceView: View {
    @State private var number = 0
    @Environment(\.presentationMode) var presentationMode
    
    @State private var intervalSheet: Bool = false
    @State private var stretchSheet: Bool = false
    @State private var bulkSheet: Bool = false
    @State private var proofSheet: Bool = false
    @State private var ovenSheet: Bool = false
    
    
    
    @AppStorage("StretchDefault") private var stretchDefault = 30
    @AppStorage("IntervalDefault") private var intervalDefault = 1
    @AppStorage("BulkDefault") private var bulkDefault = 12.0
    @AppStorage("ProofDefault") private var proofDefault = 24.0
    @AppStorage("OvenDefault") private var ovenDefault = 45
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("PREFERENCES"), content: {
                    HStack{
                        Text("Stretch and Fold")
                        Rectangle()
                            .foregroundStyle(.white)
                        Text("\(stretchDefault) minutes")
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        stretchSheet = true
                    }.sheet(isPresented: $stretchSheet){
                        WheelPickerView(number: $stretchDefault, title: "Stretch and Fold",
                            description: "The time used after combining and resting to then return and stretch and fold to build gluten and bread strength.", descriptor: "minutes", min: 0, max: 60)
                            .presentationDetents([.medium, .large])
                            .presentationBackgroundInteraction(.automatic)
                    }
                    HStack{
                        Text("Stretch Intervals")
                        Rectangle()
                            .foregroundStyle(.white)
                        Text("\(intervalDefault) times")
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        intervalSheet = true
                    }.sheet(isPresented: $intervalSheet){
                        WheelPickerView(number: $intervalDefault, title: "Stretch Intervals",
                                        description: "The default number of times that you would like to stretch and fold prior to bulk fermentation.", descriptor: "times", min: 0, max: 10)
                            .presentationDetents([.medium, .large])
                            .presentationBackgroundInteraction(.automatic)
                    }
                    HStack{
                        Text("Bulk Fermentation")
                        Rectangle()
                            .foregroundStyle(.white)
                        Text("\(String(format: "%.1f", bulkDefault)) hours")
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        bulkSheet = true
                    }.sheet(isPresented: $bulkSheet){
                        DoublePickerView(number: $bulkDefault, name: "Bulk Fermentation",
                            description: "The default time used to bulk ferment and let the bread rise.")
                            .presentationDetents([.medium, .large])
                            .presentationBackgroundInteraction(.automatic)
                    }
                    HStack{
                        Text("Shaping and Proofing")
                        Rectangle()
                            .foregroundStyle(.white)
                        Text("\(String(format: "%.1f", proofDefault)) hours")
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        proofSheet = true
                    }.sheet(isPresented: $proofSheet){
                        DoublePickerView(number: $proofDefault, name: "Shaping and Proofing",
                            description: "This will include the shaping after bulk fermenting and second rest.")
                            .presentationDetents([.medium, .large])
                            .presentationBackgroundInteraction(.automatic)
                    }
                    HStack{
                        Text("Oven Time")
                        Rectangle()
                            .foregroundStyle(.white)
                        Text("\(ovenDefault) minutes ")
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        ovenSheet = true
                    }.sheet(isPresented: $ovenSheet){
                        WheelPickerView(number: $ovenDefault, title: "Oven Time",
                            description: "This is the time that the bread is spent in the oven.", descriptor: "minutes", min: 0, max: 60)
                            .presentationDetents([.medium, .large])
                            .presentationBackgroundInteraction(.automatic)
                    }
                }
                        
                )}
        }
    }
}

#Preview {
    DefaultPreferenceView()
}
