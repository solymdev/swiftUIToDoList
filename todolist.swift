//
//  PreferencesView.swift
//
//  Created by R L on 01/02/21.
//

import SwiftUI

struct PreferencesView: View {
    
    @State var selectedPreferences : [String] = []
    @State var warnings = ""
    @State var isCorrect = false
    @ObservedObject var rows = preferencesObservable()
    
    var body: some View {
        VStack{
            Spacer()
            Text("Select your preferences")
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("txtField"))
                .overlay(
                    VStack(alignment:.leading){
                        ForEach(self.rows.rows){ preference in
                HStack{
                    Image(systemName : preference.selected ?  "checkmark.circle" : preference.image ).resizable()
                        .frame(width:20,height:20)
                        .padding(.trailing,4)
                Button(action : {
                    rows.editState(index: preference.index)
                    if (selectedPreferences.contains(preference.title)){
                        if let index = selectedPreferences.firstIndex(of: preference.title) {
                            selectedPreferences.remove(at: index)
                        }
                    }else{
                        selectedPreferences.append(preference.title)
                    }
                }){
                    Text(preference.title)
                }.buttonStyle(PlainButtonStyle())
                    
                }
            }})
            HStack{
                Text(self.warnings)//warnings
                Spacer()
                
                //arrow button
                Button(action:{
                    //self.checkInputs()
                    
                }){
                        Image(systemName: "arrow.right").resizable().frame(width:30,height:30)
                            .foregroundColor(self.isCorrect ? .green : .gray)
                }.padding(20)
            }
            Spacer()
        }.padding(20)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(req: request())
    }
}

class preferencesObservable : ObservableObject{
    
    @Published var rows : [preferenceStruct] = [
        preferenceStruct(image :  "circle",title : "Cars", selected: false, index : 0),
        preferenceStruct(image :  "circle",title : "Motorbike", selected: false, index: 1),
        preferenceStruct(image :  "circle",title : "Motors", selected: false, index: 2),
        preferenceStruct(image :  "circle",title : "Women Fashion", selected: false, index: 3),
        preferenceStruct(image :  "circle",title : "Men Fashion", selected: false, index: 4),
        preferenceStruct(image :  "circle",title : "Cameras", selected: false, index: 5),
        preferenceStruct(image :  "circle",title : "Audio", selected: false, index: 6),
        preferenceStruct(image :  "circle",title : "TV's", selected: false, index: 7),
        preferenceStruct(image :  "circle",title : "Smartphones", selected: false, index: 8),
        preferenceStruct(image :  "circle",title : "Computers & Accesories", selected: false, index: 9),
        preferenceStruct(image :  "circle",title : "Bikes", selected: false, index: 10),
        preferenceStruct(image :  "circle",title : "Games & Consoles", selected: false, index: 11),
        preferenceStruct(image :  "circle",title : "Home & Garden", selected: false, index: 12),
        preferenceStruct(image :  "circle",title : "Baby & Child", selected: false, index: 13),
        preferenceStruct(image :  "circle",title : "Collectibles & Art", selected: false, index: 14),
        preferenceStruct(image :  "circle",title : "Agriculture & Industrial", selected: false, index: 15),
        preferenceStruct(image :  "circle",title : "Other", selected: false, index: 16),
    ]
    
    func editState(index: Int){
        rows[index].selected.toggle()
    }
    
}

struct preferenceStruct : Identifiable{
    var id = UUID()
    var image : String
    var title : String
    var selected : Bool
    var index : Int
}
