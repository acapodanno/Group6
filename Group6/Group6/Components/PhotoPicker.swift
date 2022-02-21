//
//  PhotoPicker.swift
//  Group6
//
//  Created by Assunta Della Porta on 21/02/22.
//

import Foundation
import SwiftUI

struct PhotoPicker : UIViewControllerRepresentable {//è una view che rappresente un componente di UIKit
    @Binding var profileImage : UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()  //inizializza un nuovo image picker controller
        picker.delegate = context.coordinator  // quello che gestisce il photoPicker è il coordinator qui sotto
        picker.allowsEditing = true  //permette di ritagliare e riposizionare la foto
        return picker  //in questo modo la funzione ritorna un ui picker controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self) //creai il coordinator (obv makeCoordinator)
    }
    
    final class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker : PhotoPicker
        init(photoPicker: PhotoPicker) {  //bisogna fare l'inizializzatore manualmente
            self.photoPicker = photoPicker
        }
        
        //con questo medoto abbiamo accesso a ciò che l'utente seleziona (info)
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //se l'utente ha selezionato correttamente l'immagine...
            if let image  = info[.editedImage] as? UIImage {
                photoPicker.profileImage = image  //settiamo questa immagine come immagine di profilo
            }
            else {
                print("Errore nella scelta dell'immagine di profilo")
            }
            picker.dismiss(animated: true)  //quando ha finito, chiudi il picker
        }
    }
}

// TODO: comprimere l'immagine se non viene conservata in locale 
