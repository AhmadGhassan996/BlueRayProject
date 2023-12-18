//
//  APIRadiatorUseCase.swift
//  Blue Ray Project
//
//  Created by AhmadSulaiman on 15/12/2023.
//

import Foundation
enum Sections {
    case description(String, String)
    case coverImage(String)
    case arrayOfImages([Image])
    var items: Int {
        switch self {
        case .arrayOfImages(let data) : return data.count
        case .coverImage(_): return 1
        case .description(_,_): return 1
        }
    }
}
protocol RadiatorUseCaseProtocol: AnyObject {
  var pageSections: [Sections] { get }
  func fetchDataInSections(completion: @escaping (Bool) -> Void)
}
final class APIRadiatorUseCase: RadiatorUseCaseProtocol {
   private var description: Sections = Sections.description("", "")
   private var oneImage: Sections = Sections.coverImage("")
   private var arrayOfImages: Sections = Sections.arrayOfImages([])
    private var _pageSections: [Sections] = []
     var pageSections: [Sections] {
         get {
             return [description, oneImage, arrayOfImages]
         }
         set {
             _pageSections = newValue
         }
     }
    func fetchDataInSections(completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.request(urlString: "https://siyam.br-ws.com/get-content-by-category-id", method: .post, parameters: ["category_id": 1]) { [weak self] (result: Result<RadiatorModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let firstData = response.data.first {
                    self.description = Sections.description(firstData.title, firstData.body)
                    self.oneImage = Sections.coverImage(firstData.coverImage)
                    self.arrayOfImages = Sections.arrayOfImages(firstData.images)
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(let error):
                print("Error: \(error)")
                completion(false)
            }
        }
    }
}
