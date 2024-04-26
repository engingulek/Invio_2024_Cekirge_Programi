import Foundation
import RealmSwift
class Favorities: Object  {
    @Persisted var opened : Bool = false
    @Persisted var name:String = ""
    @Persisted  var phone:String = ""
    @Persisted  var fax: String = ""
    @Persisted  var website: String = ""
    @Persisted  var email : String = ""
    @Persisted  var adress : String = ""
    @Persisted  var rector: String = ""
    
}


extension Favorities {
    static var favoritiesOne: Favorities {
        let favorities = Favorities()
        favorities.opened = false
        favorities.name = "İstanbul Üniversitesi"
        favorities.phone = "Default Phone"
        favorities.fax = "Default Fax"
        favorities.website = "Default Website"
        favorities.email = "Default Email"
        favorities.adress = "Default Address"
        favorities.rector = "Default Rector"
        return favorities
    }
    
    static var favoritiesTwo: Favorities {
        let favorities = Favorities()
        favorities.opened = false
        favorities.name = "Ankara Üniversitesi"
        favorities.phone = "-"
        favorities.fax = "-"
        favorities.website = "-"
        favorities.email = "-"
        favorities.adress = "-"
        favorities.rector = "-"
        return favorities
    }
}
