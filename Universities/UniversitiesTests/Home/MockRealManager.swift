import Foundation
@testable import Universities


class MockRealManager : RealmManagerProtocol {
    var favoriteList : [Favorities] = []
    func allGetFavorities() -> [Favorities] {

        return favoriteList
    }
    
    func addFavoritiy(university: University) {
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
        favoriteList.append(fav)
    }
    
    func deleteFavorities(university: University) {
        
    }
    
    
}
