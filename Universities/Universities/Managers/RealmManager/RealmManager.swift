
import Foundation
import RealmSwift


protocol RealmManagerProtocol {
    func allGetFavorities() -> [Favorities]
    func addFavoritiy(university:University)
    func deleteFavorities(university:University)
}


class RealmManager :  RealmManagerProtocol {
    private(set) var localRealm : Realm?
    private var favorities : [Favorities] = []
    
    init(){
        openRealm()
    }
    
    private func openRealm(){
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm  = try Realm()
        }catch{
            print("Error opening Realm", error)
        }
    }
    
    func allGetFavorities() -> [Favorities] {
        if let localRealm = localRealm {
           let allFavs = localRealm.objects(Favorities.self)
            favorities = []
            allFavs.forEach { fav in
                favorities.append(fav)
            }
            return favorities
        }
        return []
    }
    
    func addFavoritiy(university: University)  {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let fav = Favorities(
                        value: [
                             "opened" : false,
                             "name":university.name,
                             "phone":university.phone,
                             "fax":university.fax,
                             "website": university.website,
                             "email" :university.email,
                             "adress" : university.adress,
                             "rector":university.rector
                        
                        ])
                    localRealm.add(fav)
                   
                }
            }catch{
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    
    func deleteFavorities(university: University) {
        if let localRealm = localRealm{
                   do{
                       let favoriteDelete = localRealm.objects(Favorities.self).filter(NSPredicate(format: "name == %@", university.name))
                       guard !favoriteDelete.isEmpty else {return}
                       
                       try localRealm.write{
                           localRealm.delete(favoriteDelete)
                       
                       }
                   }catch{
                       print("Error adding task to Realm: \(error)")
                   }
               }
    }
}
