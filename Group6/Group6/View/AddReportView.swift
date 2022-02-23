
import SwiftUI



struct AddReportView: View {
    
    @StateObject var locationManager = LocationManager()
    var reportApi:ReportApi = ReportApi()
    @State private var showingAlert = false
    @State var lastNoteValue : String = ""
    @State var note : String = ""
    @State var tempImg : UIImage?
    @State var imageArray : [UIImage?] = []
    @State private var isImagePickerDisplay = false
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationView{
            
            Form{
                Section(header: Text("Location")){
                    HStack{
                        Text(locationManager.address)
                        Spacer()
                        Image(systemName: "mappin")
                    }
                }
                Section(header: Text("Date")){
                    HStack{
                        Text(Date().formatted())
                        Spacer()
                        Image(systemName: "calendar")
                    }
                }
                Section(header: Text("Photo"), footer: Text("\(5 - imageArray.count) \(note.count == 199 ? "photos" : "photo") remaining")){
                    HStack{
                        ScrollView(.horizontal) {
                            HStack {
                                if(imageArray.count < 5 ){
                                    Button(action: {
                                        self.isImagePickerDisplay.toggle()
                                    }){
                                        Image(systemName: "camera.circle").font(.title)
                                            .padding(.all, 50.0)
                                    }
                                }
                                ForEach(imageArray, id: \.self) {selectedImage in
                                    if selectedImage != nil {
                                        Image(uiImage: selectedImage!)
                                            .resizable()
                                            .frame(width:100, height: 100)
                                    } else {
                                        Image(systemName: "rectangle.fill")
                                            .resizable()
                                            .foregroundColor(Color("AccentColor"))
                                            .frame(width: 100, height: 100)
                                    }
                                }
                            }
                        }
                    }
                }
                Section(header: Text("Note"), footer: Text("\(200 - note.count) \(note.count == 199 ? "character" : "characters") remaining")){
                    HStack{
                        TextEditor(text: $note).onChange(of: note){
                            value in
                            if(value.count <= 200){
                                
                                lastNoteValue = value
                            }else{
                                note = lastNoteValue
                            }
                        }
                        
                        Spacer()
                        Image(systemName: "note.text")
                    }
                }
                
            }.navigationBarTitle("New Report").navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
                
            }){
                Image(systemName: "xmark").font(.title2)
            }, trailing: Button(action: {
                saveReport()
                
            }){
                Image(systemName: "checkmark").font(.title2)
            }).alert(isPresented: $showingAlert){
                Alert(title: Text("Cannot save"), message: Text("Insert at least one photo to save your report"), dismissButton: .default(Text("Ok")))
            }
            .sheet(isPresented: self.$isImagePickerDisplay, onDismiss: {
                if tempImg != nil {
                    imageArray.append(tempImg)
                }
            }) {
                ImagePickerView(selectedImage: $tempImg)
            }
        }
        
        
        
    }
    func saveReport(){
        print ("\(note)")
        reportApi.addReport(latitude: locationManager.placeMark?.location?.coordinate.latitude ?? 0, longitude: locationManager.placeMark?.location?.coordinate.longitude ?? 0, description: note,address:"\(locationManager.address)")
        
     //   if(imageArray.count < 1){
            showingAlert.toggle()
     //   }else{
            presentationMode.wrappedValue.dismiss()
            //Send to db Report("Location: location, Date: date, photo : photo, note : note ")
     //   }
    }
}

struct AddReportView_Previews: PreviewProvider {
    static var previews: some View {
        AddReportView()
    }
}
