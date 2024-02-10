//
//  ContactRemoteImage.swift
//  Pago
//
//  Created by radu on 10.02.2024.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    func load(fromURLString urlString: String) {
        NetworkCallManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            guard let uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

struct ContactRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    let name: String
    let idx:Int
    let circleColor = #colorLiteral(red: 0.7568552494, green: 0.7843158841, blue: 0.8431333899, alpha: 1)
    var body: some View {
        if(idx.isMultiple(of: 2)){
            ZStack {
                Circle()
                    .frame(width:56, height: 56)
                    .foregroundColor(Color(circleColor))
                imageLoader.image?.resizable()
                
            }
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width:56, height: 56)
                .onAppear { imageLoader.load(fromURLString:"https://picsum.photos/200/200?id=\(idx)") }
        }
        else{
            ExtractContactInitials(name:name)
        }
    }
}

struct ExtractContactInitials: View {
    
    let name: String
    let circleClor = #colorLiteral(red: 0.7568552494, green: 0.7843158841, blue: 0.8431333899, alpha: 1)
    func initials(_ input:String ) -> String {
        let excludedSuffix = "."
        let components = input.components(separatedBy: " ")
        let filteredComponents = components.filter { component in
            !component.hasSuffix(excludedSuffix)
        }
        let firstTwoInitials = filteredComponents.prefix(2).compactMap { $0.first.map(String.init) }.joined()
        return firstTwoInitials
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width:56, height: 56)
                .foregroundColor(Color(circleClor))
            Text(initials(name))
                .foregroundColor(.white)
                .font(.headline)
        }
    }
}
