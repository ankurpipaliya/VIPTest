
import Foundation
import UIKit

class FileEditor : NSObject {
    
    
    
    override init() {
        
    }
    
    
    func writeFileInDocumentDirectory(strPath : String,strFolderName:String,data:Data) -> URL? {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            var fileURL = documentDirectory.appendingPathComponent(strFolderName)
            try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true, attributes: nil)
            fileURL = fileURL.appendingPathComponent(strPath)
            try data.write(to: fileURL)
            return fileURL
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getFilePath(strPath : String) -> URL? {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(strPath)
            return fileURL
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deleteFileAtPath(strPath:String,strFolderName:String) {
        let fileManager = FileManager.default
        do {
            let url = URL(fileURLWithPath: strPath)
            let strImage = strFolderName + url.lastPathComponent
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(strImage)
            try fileManager.removeItem(at: fileURL)
            
        }catch {
            print(error.localizedDescription)
        }
    }
    
    class func getDocumentDirectoryPath() -> URL? {
        let fileManager = FileManager.default
        let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        return documentDirectory
    }
}
