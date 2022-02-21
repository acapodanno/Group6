//
//  PhotoPicker.swift
//  Group6
//
//  Created by Assunta Della Porta on 21/02/22.
//

import Foundation
import SwiftUI

struct PhotoPicker : UIViewControllerRepresentable {  //è una view che rappresente un componente di UIKit
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()  //inizializza un nuovo image picker controller
        picker.allowsEditing = true  //permette di ritagliare e riposizionare la foto
        return picker  //in questo modo la funzione ritorna un ui picker controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    typealias UIViewControllerType = UIImagePickerController
    
    
}
