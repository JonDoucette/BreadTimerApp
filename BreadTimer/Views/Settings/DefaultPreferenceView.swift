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
                        WheelPicker(number: $stretchDefault, title: "Stretch and Fold",
                            description: "The time used after combining and resting to then return and stretch and fold to build gluten and bread strength.", min: 0, max: 60)
                            .presentationDetents([.medium, .large])
                            .presentationBackgroundInteraction(.automatic)
                    }
                    HStack{
                        Text("Bulk Fermentation")
                        Rectangle()
                            .foregroundStyle(.white)
                        Text("\(String(format: "%.2f", bulkDefault)) hours")
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        bulkSheet = true
                    }.sheet(isPresented: $bulkSheet){
                        WheelPicker(number: $stretchDefault, title: "Bulk Fermentation",
                            description: "The default time used to bulk ferment and let the bread rise.", min: 0, max: 60)
                            .presentationDetents([.medium, .large])
                            .presentationBackgroundInteraction(.automatic)
                    }
                    HStack{
                        Text("Shaping and Proofing")
                        Rectangle()
                            .foregroundStyle(.white)
                        Text("\(String(format: "%.2f", proofDefault)) hours")
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        proofSheet = true
                    }.sheet(isPresented: $proofSheet){
                        WheelPicker(number: $stretchDefault, title: "Shaping and Proofing",
                            description: "This will include the shaping after bulk fermenting and second rest.", min: 0, max: 60)
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
                        WheelPicker(number: $ovenDefault, title: "Oven Time",
                            description: "This is the time that the bread is spent in the oven.", min: 0, max: 60)
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
