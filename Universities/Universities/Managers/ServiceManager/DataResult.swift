import Foundation

struct DataResult : Decodable {
    let currentPage, totalPage, total, itemPerPage: Int
    let pageSize: Int
    let data: [City]
    
}

struct City: Decodable  {
    var opened : Bool? = false
    let id: Int
    let province: String
    var universities: [University]
}

struct University: Decodable  {
    var opened : Bool? = false
    let name, phone, fax: String
    let website: String
    let email, adress, rector: String
}


extension DataResult {
   static var defaultDataResult = DataResult(
          currentPage: 2,
          totalPage: 3,
          total: 82,
          itemPerPage: 30,
          pageSize: 30,
          data: [
              .init(id: 1,
                    province: "İstanbul",
                    universities: [
                      .init(name: "İstanbul Üniversitesi",
                            phone: "11111111",
                            fax: "1111111",
                            website: "wwww",
                            email: "",
                            adress: "",
                            rector: ""),
                      
                          .init(
                              name: "Fenerbahçe Üniversitesi",
                              phone: "-",
                              fax: "-",
                              website: "-",
                              email: "-",
                              adress: "-",
                              rector: "-")
                      
                      
                    
                    ]),
              .init(id: 2, province: "Ankara", universities: [
                  .init(name: "Ankara Üniversitesi",
                        phone: "11111111",
                        fax: "1111111",
                        website: "wwww",
                        email: "",
                        adress: "",
                        rector: "")
              ]),
                  .init(
                      id: 4,
                      province: "Üniversitesiz Şehir",
                      universities: [])
          ])
}

