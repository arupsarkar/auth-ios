//
//  ColorExtension.swift
//  sfdc-jwt-identity
//
//  Created by Arup Sarkar on 2/10/21.
//

import SwiftUI

//struct ColorExtension: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct ColorExtension_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorExtension()
//    }
//}

extension Color {
  static var gradient: Array<Color> {
    return [
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 1.0),
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.7),
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.5),
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.2),
      Color(red: 5/255, green: 5/255, blue: 5/255, opacity: 1.0)
    ]
  }
}
